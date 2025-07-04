import 'package:flutter/material.dart';
import 'package:untitled/screens/screens.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/services/services.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/' : (context) => Home(),
      '/register' : (context) => Register(),
      // '/chat' : (context) => ChatScreen(),
      '/login' : (context) => Login()
    },

    debugShowCheckedModeBanner: false,

  ));
}
