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
              SizedBox(height : 20),
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                  child: Icon(Icons.arrow_back),
                ),
              ),
              const StaticText("Tạo tài khoản"),
              SizedBox(height: 20),
              const StaticText("Tên hiển thị"),
              SizedBox(height : 20),
              CustTextField(hide: false, controller: widget._fullname),
              SizedBox(height : 20),
              const CustText("Tai khoan"),
              SizedBox(height: 20),
              CustTextField(hide: false, controller: widget._username),
              SizedBox(height : 20),
              const CustText("Mat khau"),
              SizedBox(height : 20),
              CustTextField(hide: true, controller: widget._password),
              SizedBox(height: 20),
              const CustText("Nhap lai mat khau"),
              SizedBox(height : 20),
              CustTextField(hide: true, controller: widget._retype),
              SizedBox(height: 20),
              CustElevatedButton(text: 'Tao tai khoan', onPressed: ()=> OnClick()),

          ],
        
        ),
      ),
    );
  }
  void OnClick(){
    print("Click Sign Up");
    String fullname = widget._fullname.text;
    String username = widget._username.text;
    String password = widget._password.text;
    String retype = widget._retype.text;

    Navigator.pop(context);
  }

}