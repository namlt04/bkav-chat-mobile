

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
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
            print('$token');
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
    Future<List<Message>> getMessageAll(String friendId) async{
      List<Message> list = [];
      Uri url = Uri.http(AppUrl.host, '/api/message/get-message', {'FriendID' : friendId});
      final http.Response response = await http.get(
       url,
       headers : { 'Authorization' : 'Bearer ${token}' }
      );

      if ( response.statusCode == 200){
        // ghi vao trong local database
        final Map<String, dynamic> body = jsonDecode(response.body);
        final data = List<Map<String, dynamic>>.from(body['data']); // chuyen no thanh List<dynamic>
        list = await handleMessage(data, friendId);
        // list = await handleMessage(body['data'], friendId);
        // ghi vao trong database
        for( Message message in list) {
          IsarServices.instance.saveMessage(message);
        }
      }
      print(' Da lay thanh cong toan bo tin nhan ');
      return list;

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
    Future<List<Message>> sendMessage(String content, String friendId, List<File> files) async {
        // gui tin nhan, nhan response
        // tach tin nhan
        List<Message> list = [];  
        Uri url = Uri.http(AppUrl.host, '/api/message/send-message');
        final http.MultipartRequest request = http.MultipartRequest('POST', url);

        request.headers['Authorization'] = 'Bearer $token';
        request.fields['FriendID'] = friendId;
        request.fields['Content'] = content;

        for ( File file in files) {
          final mimeType = lookupMimeType(file.path); // Ví dụ: image/jpeg
          final mediaType = mimeType != null ? MediaType.parse(mimeType) : MediaType('application', 'octet-stream');
          request.files.add(
            await http.MultipartFile.fromPath(
                'files',
                file.path,
                filename: basename(file.path),
                contentType: mediaType,
            )
          );

        }
        final http.StreamedResponse streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if ( response.statusCode == 200 ) // gui thanh cong
          {
            final Map<String, dynamic> body = jsonDecode(response.body);
            List<Map<String, dynamic>> tmpList = [];
            tmpList.add(body['data']);
            list = await handleMessage(tmpList, friendId);
            // ghi vao trong database
            for( Message message in list) {
              IsarServices.instance.saveMessage(message);
            }     // ghi vao trong database


          }


        return list;
    }
    Future<void> downloadFile(String url, bool isClick) async {
      // Tu dong lay file
      Uri uri = Uri.http(AppUrl.host, '/api${url}' );
      final http.Response response = await http.get(uri);
      if ( response.statusCode == 200)
        {
          final String savePath = '${AppUrl.path}${url}';
          File file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);
          if (isClick) // Neu file duoc luu do yeu cau cua nguoi su dung:w
            print('Anh da duoc luu tai $savePath');
        }
    }
    Future<List<Message>> handleMessage(List<Map<String, dynamic>> body, String friendId) async {
      // truyen vao 1 list

      List<Message> list = [];
      // { <----- nhu nay, ma phai su dung kieu khac
      for (Map<String, dynamic> item in body){
        if ( item['Content'] != ''){
          // neu item['content'] khac voi rong thi gan tin nhan nay vao
          Message message = Message();
          message.type = 0;
          message.uuid = item['id'];
          message.content = item['Content'];
          // khong can tinh truoc kich thuoc
          message.link = '';
          message.height = 0;
          message.width = 0;
          message.friendId = friendId;
          message.lastTime = item['CreatedAt'];
          message.messageType = item['MessageType'];
          list.add(message);
        }
        if ( item['Files'].length != 0 ){
            for ( Map<String, dynamic> attach in item['Files']) {
              Message message = Message();
              message.type = 2;
              message.uuid = attach['_id'];
              message.link = attach['urlFile'];
              message.content = attach['FileName'];
              message.height = 0 ;
              message.width = 0;
              message.friendId = friendId;
              message.lastTime = item['CreatedAt'];
              message.messageType = item['MessageType'];
              list.add(message);
            }
        }
        if ( item['Images'].length != 0){
          // tao cac tin nhan
          // kiem tra xem file da duoc tai ve hay chua
          for ( Map<String, dynamic> attach in item['Images']) {
            Message message = Message();
            message.type = 1;
            message.link = attach['urlImage'];
            final String tmpPath = '${AppUrl.path}${message.link}';
            final File file = File(tmpPath);
            if ( ! await file.exists() ){
                // goi ham api tai ve

              await downloadFile(message.link, false);
            }
            // Tinh kich thuoc
            File imgSizeCalc = File(tmpPath);
            final Uint8List bytes = await imgSizeCalc.readAsBytes();
            //
            // decodeImageFromList(bytes, (Image image){
            //    message.width = image.width;
            //    message.height = image.height;
            // });
            final codec = await instantiateImageCodec(bytes);
            final frame = await codec.getNextFrame();
            message.width = frame.image.width;
            message.height = frame.image.height;
            // Tinh lai kich thuoc
            final double aspectRatio = message.width / message.height ;
            if ( message.width >  App.width * 0.55){
              message.width = (App.width * 0.55).toInt();
              message.height = (message.width / aspectRatio).toInt() ;
            }

            message.content = attach['FileName'];
            message.uuid = attach['_id'];
            message.friendId = friendId;
            message.lastTime = item['CreatedAt'];
            message.messageType = item['MessageType'];
            list.add(message);
          }
        }
      }
      return list;
    }


}