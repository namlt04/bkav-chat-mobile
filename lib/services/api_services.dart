

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:untitled/services/constants.dart';
import 'package:untitled/services/isar_services.dart';
import 'entities.dart';
import 'package:path/path.dart';
import 'package:untitled/models/message.dart';
class ApiServices
{
    static final ApiServices instance = ApiServices._internal();
    factory ApiServices(){
      return instance;
    }
    ApiServices._internal();
    late final String token;
    // login
    Future<bool> login(String username, String password) async{
      Uri url = Uri.http(AppUrl.host, "/api/auth/login");

      final http.Response response = await http.post(
        url,
        headers : {
            'Content-Type' : 'application/json',
        },
        body : jsonEncode({
            'Username' : username,
            'Password' : password
        })
      );


      if ( response.statusCode == 200){
        final Map<String, dynamic> body = jsonDecode(response.body);
        if ( body['status'] == 0){
            return false;
        }
        else {
            token = body['data']['token'];
            return true;
        }
      }


      return false;
    }
    Future<bool> register(String fullname, String username, String password) async {
        Uri url = Uri.http(AppUrl.host, "/api/auth/register");


        final http.Response response = await  http.post(
            url,
            headers : {
                "Content-Type" : "application/json"
            },
            body : jsonEncode({
                "Fullname" : fullname,
                "Username" : username,
                "Password" : username,

            })


        );

        if ( response.statusCode == 200){
            final Map<String, dynamic> body = jsonDecode(response.body);
            if ( body['status'] == 1){
                return true;

            } return false;


        } else return false;
        return false ;


    }
    Future<List<User>> getFriend() async{
        Uri url = Uri.http(AppUrl. host, '/api/message/list-friend');

        List<User> list = [];
        final http.Response response =await  http.get(
         url,
         headers:{
            'Authorization' : "Bearer $token"
         }
        );
        if( response.statusCode == 200){
          final Map<String, dynamic> body = jsonDecode(response.body);
          for (dynamic friend in body['data']){
            final User user =  User(content : friend['Content'],username :  friend['Username'],friendid :  friend['FriendID']);
            list.add(user);
          }
        }
        return list;
    }
    Future<void> getMessageAll(String friendId) async{
      Uri url = Uri.http(AppUrl.host, '/api/message/get-message', {'FriendID' : friendId});
      final http.Response response = await http.get(
       url,
       headers : { 'Authorization' : 'Bearer ${token}' }
      );

      if ( response.statusCode == 200){
        // ghi vao trong local database
        final Map<String, dynamic> body = jsonDecode(response.body);
        List<Message> list = await handleMessage(body);
        // ghi vao trong database
        for( Message message in list) {
          IsarServices.instance.saveMessage(message);
        }
      }

    }
    Future<void> getMessageLast(String friendId, String lastTime) async{
      Uri url = Uri.http(AppUrl.host, '/api/message/get-message', {'FriendID' : friendId, 'LastTime' : lastTime});
      final http.Response response = await http.get(
          url,
          headers : { 'Authorization' : 'Bearer $ApiServices.token' }
      );

      if ( response.statusCode == 200){

      }
    }
    Future<List<Message>> sendMessage(String content, String FriendID, List<File> files) async {
        // gui tin nhan, nhan response
        // tach tin nhan
        List<Message> list = [];  

        Uri url = Uri.parse('http://10.0.2.2:8888/api/message/send-message');
        final http.MultipartRequest request = http.MultipartRequest('POST', url);


        request.fields['FriendID'] = FriendID;
        request.fields['Content'] = content;


        for ( File file in files) {
          request.files.add(
            await http.MultipartFile.fromPath(
                'files',
                file.path,
                filename: basename(file.path)
            )
          );

        }
        final http.StreamedResponse streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if ( response.statusCode == 200 )
          {
            final Map<String, dynamic> body = jsonDecode(response.body);
            list = await handleMessage(body);
            // ghi vao trong database
            for( Message message in list) {
              IsarServices.instance.saveMessage(message);
            }     // neu dang o man hinh chat thi dua vao

          }


        return list;
    }
    Future<void> downloadFile(String url, bool isClick) async {
      // Tu dong lay file
      final http.Response response = await http.get(Uri.parse(url));

      if ( response.statusCode == 200)
        {
          String fileName = basename(url);
          final List<String> list = url.split('/');

          late final String savePath = '${AppUrl.path}/${url}';

          File file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);

          if (isClick) // Neu file duoc luu do yeu cau cua nguoi su dung:w
            print('Anh da duoc luu tai $savePath');
        }
    }
    Future<List<Message>> handleMessage(Map<String, dynamic> body) async {
      List<Message> list = [];
      for (Map<String, dynamic> item in body['data']){
        if ( item['Content'] != ''){
          // neu item['content'] khac voi rong thi gan tin nhan nay vao
          Message message = Message();
          message.type = 0;
          message.content = item['Content'];
          // khong can tinh truoc kich thuoc
          message.lastTime = item['CreatedAt'];
          message.messageType = item['MessageType'];
          list.add(message);
        }
        if ( item['Files'].size() != 0 ){
            for ( Map<String, dynamic> attach in item['Files']) {
              Message message = Message();
              message.type = 2;
              message.link = attach['urlFile'];
              message.content = attach['FileName'];
              message.lastTime = item['CreatedAt'];
              message.messageType = item['MessageType'];
              list.add(message);
            }
        }
        if ( item['Images'].size() != 0){
          // tao cac tin nhan
          // kiem tra xem file da duoc tai ve hay chua
          for ( Map<String, dynamic> attach in item['Images']) {
            Message message = Message();
            message.type = 1;
            message.link = attach['urlImage'];
            final String tmpPath = '${AppUrl.path}/${message.link}';
            final File file = File(tmpPath);
            if ( ! await file.exists() ){
                // goi ham api tai ve
              await downloadFile(message.link, false);

            }
            message.content = attach['fileName'];
            message.lastTime = item['CreatedAt'];
            message.messageType = item['MessageType'];
            list.add(message);
          }
        }
      }
      return list;
    }


}