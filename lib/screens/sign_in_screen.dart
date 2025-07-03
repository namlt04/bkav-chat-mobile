import 'package:flutter/material.dart';
import 'package:untitled/widgets/cust_elevated_button.dart';
import 'package:untitled/widgets/cust_text.dart';
import 'package:untitled/widgets/cust_text_button.dart';
import 'package:untitled/widgets/cust_text_field.dart';
import 'package:untitled/widgets/logo_text.dart';
import 'package:untitled/services/services.dart';
class SignInScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignInScreenState();
  }

}

class SignInScreenState extends State<SignInScreen>{

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
          LogoText(),
          SizedBox(height: 20),
          const CustText("Tai khoan"),
          SizedBox(height: 20),
          CustTextField(hide: false,controller: _usernameController),
          SizedBox(height: 20),
          const CustText("Mat khau"),
          SizedBox(height: 20),
          CustTextField(hide: true,controller: _passwordController),
          SizedBox(height: 30,),
          CustElevatedButton(
              text: "Dang nhap",
              onPressed: ()=> OnClickSignIn()
          ),
          SizedBox(height: 10),
          CustTextButton(text: "Dang ki", onPressed: () => OnClickSignUp())
        ],
      
      )
      ),
    );
  }
  void OnClickSignIn(){
    String username = _usernameController.text;
    String password = _passwordController.text;
    print(username);
    print(password);
    if (false){
      // Navigator.pushNamed(context, '/');
    }

  }
  void OnClickSignUp(){
    print("Click Sign up button");
    Navigator.pushNamed(context, '/register');
  }
  
}