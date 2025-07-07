import 'package:flutter/material.dart';
import 'package:untitled/screens/screens.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/' : (context) => Home(),
        '/register' : (context) => Register(),
        '/chat' : (context) => Chat(),
        '/login' : (context) => Login()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
