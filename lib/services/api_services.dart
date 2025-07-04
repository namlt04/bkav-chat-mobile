

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'entities.dart';
class ApiServices
{
    static String token = '';
    static final String host = '10.0.2.2:8888';
    // login
    static Future<bool> login(String username, String password) async{
      Uri url = Uri.http(host, "/api/auth/login");

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
    static Future<bool> register(String fullname, String username, String password) async {
        Uri url = Uri.http(host, "/api/auth/register");


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
    static Future<List<User>> getFriend() async{
        Uri url = Uri.http(host, '/api/message/list-friend');

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
    static Future<void> getMessageAll(String friendId) async{
      Uri url = Uri.http(host, '/api/message/get-message', {'FriendID' : friendId});
      final http.Response response = await http.get(
       url,
       headers : { 'Authorization' : 'Bearer $ApiServices.token' }
      );


      if ( response.statusCode == 200){

      }

    }
    static Future<void> getMessageLast(String friendId, String lastTime) async{
      Uri url = Uri.http(host, '/api/message/get-message', {'FriendID' : friendId, 'LastTime' : lastTime});
      final http.Response response = await http.get(
          url,
          headers : { 'Authorization' : 'Bearer $ApiServices.token' }
      );

      if ( response.statusCode == 200){

      }
    }
    static Future<void> sendMessage(String content, String FriendID, List<File> file) async {

    }
}