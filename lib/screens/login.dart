import 'package:flutter/material.dart';
import 'package:untitled/services/isar_services.dart';

import 'package:untitled/services/services.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget{

  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }

}

class LoginState extends State<Login>{

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisible = false;
  String strError = AppText.strAccountEmptyError;
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    NetworkObserver.startNetworkMonitor(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body : Column(
        children: [
          SizedBox(height: 10),
          LogoText(),
          SizedBox(height: 20),
          StaticText(AppText.strAccount),
          SizedBox(height: 20),
          CustTextField(hide: false,controller: _usernameController),
          SizedBox(height: 20),
          StaticText(AppText.strPassword),
          SizedBox(height: 20),
          CustTextField(hide: true,controller: _passwordController),
          Visibility(
              visible: _isVisible,
              child: Text(
                  strError,
                  style: TextStyle(
                    color: Colors.red,
                  ),
              )
          ),
          SizedBox(height: 350,),
          CustElevatedButton(
              text: AppText.strLogin,
              onPressed: ()=> OnClickSignIn()
          ),
          SizedBox(height: 10),
          CustTextButton(text: AppText.strRegister, onPressed: () => OnClickSignUp())
        ],
      
      )
      ),
    );
  }
  void OnClickSignIn() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool result = await ApiServices.instance.login(username, password);
    if (result){
      await IsarServices.instance.db;
      Navigator.pushNamed(context, '/');
    } else {
      setState(() {
          strError = AppText.strPasswordMismatch;
          _isVisible = true;
          Future.delayed(Duration(seconds: 3), (){
            setState(() {
              _isVisible = false;
            });
          });
      });
    }

  }
  void OnClickSignUp(){
    print("Click Sign up button");
    Navigator.pushNamed(context, '/register');
  }
  
}