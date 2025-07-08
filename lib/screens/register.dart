import 'package:flutter/material.dart';
import 'package:untitled/widgets/static_text.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/services/services.dart';
class Register extends StatefulWidget{
  Register({Key? key});
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _retype = TextEditingController();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }

}
class RegisterState extends State<Register>{
  bool _isShow = false;
  String _text = "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
        
          children: [
              LogoText(),
              SizedBox(height : 10),

              Row(
                children: [
                  SizedBox(width: 5),
                  GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                       },
                      child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(width : 65),
                  StaticText(AppText.strCreateAccount),
                ],
              ),
              SizedBox(height : 10),
              SizedBox(height: 5),
              const StaticText("Tên hiển thị"),
              CustTextField(hide: false, controller: widget._fullname),
              SizedBox(height : 10),
              StaticText(AppText.strAccount),
              CustTextField(hide: false, controller: widget._username),
              SizedBox(height : 10),
              StaticText(AppText.strPassword),
              CustTextField(hide: true, controller: widget._password),
              SizedBox(height: 10),
              StaticText(AppText.strRePassword),
              CustTextField(hide: true, controller: widget._retype),
              SizedBox(height: 250),
              CustElevatedButton(text: AppText.strCreateAccount, onPressed: ()=> OnClick()),

          ],
        
        ),
      ),
    );
  }
  void OnClick(){
    String fullname = widget._fullname.text;
    String username = widget._username.text;
    String password = widget._password.text;
    String retype = widget._retype.text;

    Navigator.pop(context);
  }

}