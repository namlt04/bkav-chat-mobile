

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
import 'package:untitled/models/user.dart';
import 'package:path/path.dart';
import 'package:untitled/models/message.dart';
import 'package:untitled/models/synced_friend.dart';
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
                "FullName" : fullname,
                "Username" : username,
                "Password" : password,

            })
        );

        if ( response.statusCode == 200){
            final Map<String, dynamic> body = jsonDecode(response.body);
            if ( body['status'] == 1){
                return true;
            }
        }
        return false;
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
            String? avatarLink;
            if ( friend.containsKey('Avatar')) {
              await autoGetResource(friend['Avatar']);
              avatarLink = friend['Avatar'];
            }
            String? fullname;
            if ( friend.containsKey('FullName')) {
              await autoGetResource(friend['FullName']);
              fullname = friend['FullName'];
            }
            String content = "";
              if (friend['Content'] == "") {
                if (friend['Files']!= null )
                  content += '${friend['Files'].length} tap tin';
                if (friend['Images'] != null )
                  if (content == "")
                      content += '${friend['Images'].length} hinh anh';
                  else
                    content += ' va ${friend['Images'].length} hinh anh';
                if (content == "")
                  content = 'Khong co tin nhan moi';
              }
              else content = friend['Content'];
              print(content);
            final User user =  User(content : content,username :  friend['Username'],friendId :  friend['FriendID'],isOnline : friend['isOnline'],   avatar: avatarLink, Fullname: fullname);
            list.add(user);
          }
        }
        return list;
    }
    Future<void> getMessageAll(String friendId) async{
      // Kiem tra no da ton tai trong databse hay chua
      // Co : tai xuong toan bo,
      // Chua : dong bo no voi databse bang GetMessageLast

      final SyncedFriend? result = await IsarServices.instance.checkSynced(friendId);
      if ( result != null){

        final DateTime lastTime = result.syncedAt;
        final String strLastTime = lastTime.toIso8601String();
        //
        await getMessageLast(friendId, strLastTime);
        return;
      }
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
        
        // ghi vao trong database
        for( Message message in list) {
          IsarServices.instance.saveMessage(message);
        }
      }
      if ( list.isNotEmpty) {
          Message message = list.last;
          updateSynced(friendId, message);
      }
    }

    Future<void> getMessageLast(String friendId, String lastTime) async{
      Uri url = Uri.http(AppUrl.host, '/api/message/get-message', {'FriendID' : friendId, 'LastTime' : lastTime});
      // Truy van lasttime lan cuoi
      final http.Response response = await http.get(
          url,
          headers : { 'Authorization' : 'Bearer $ApiServices.token' }
      );

      if ( response.statusCode == 200){
        // Tan dung lai code phan getMessageAll
        final Map<String, dynamic> body = jsonDecode(response.body);
        final data = List<Map<String, dynamic>>.from(body['data']); // chuyen no thanh List<dynamic>
        List<Message> list = await handleMessage(data, friendId);
        // list = await handleMessage(body['data'], friendId);
        // ghi vao trong database
        for( Message message in list) {
          IsarServices.instance.saveMessage(message);
        }
        if ( list.isNotEmpty) {
          Message message = list.last;
          updateSynced(friendId, message);
        }
      }
    }
    void updateSynced(String friendId, Message message) async{
      SyncedFriend sf = SyncedFriend();
      sf.friendId = friendId;
      sf.syncedAt = message.createAt;
     await IsarServices.instance.updateSynced(sf);
    }
    Future<List<Message>> sendMessage(String content, String friendId, List<File> files) async {
        // gui tin nhan, nhan response
        // response duoc ghi vao local database
        // luu response truc tiep duoc them vao list dang hien thi
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
            }
          }
        return list;
    }
    Future<void> autoGetResource(String url) async {
      // Tu dong lay file
      Uri uri = Uri.http(AppUrl.host, '/api${url}' );
      final http.Response response = await http.get(uri);
      if ( response.statusCode == 200)
        {
          final String savePath = '${AppUrl.path}${url}';
          File file = File(savePath);
          await file.writeAsBytes(response.bodyBytes);
        }
    }
    Future<void> getResource(String url) async {
      // Tu dong lay file
      Uri uri = Uri.http(AppUrl.host, '/api${url}' );
      final http.Response response = await http.get(uri);

      if ( response.statusCode == 200)
      {
          String filename = basename(url);
            String downloadPath = '/storage/emulated/0/Download';
            File file = File('${downloadPath}/${filename}');
            await file.writeAsBytes(response.bodyBytes);
          print('File da duoc luu tai /Downloads');
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
          message.createAt = DateTime.parse(item['CreatedAt']);
          message.saveTime = DateTime.now();
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
              message.createAt =DateTime.parse(item['CreatedAt']);
              message.saveTime = DateTime.now();
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

              await autoGetResource(message.link);
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
            message.createAt = DateTime.parse(item['CreatedAt']);
            message.saveTime = DateTime.now();
            message.messageType = item['MessageType'];
            list.add(message);
          }
        }
      }
      return list;
    }


}