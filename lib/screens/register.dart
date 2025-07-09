import 'package:flutter/material.dart';
import 'package:untitled/widgets/static_text.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/services/services.dart';
class Register extends StatefulWidget{
  Register({Key? key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }

}
class RegisterState extends State<Register>{
  bool _isVisible = false;
  String _strError = "";

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _retype = TextEditingController();

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
              StaticText(AppText.strFullname),
              CustTextField(hide: false, controller: _fullname),
              SizedBox(height : 10),
              StaticText(AppText.strAccount),
              CustTextField(hide: false, controller: _username),
              SizedBox(height : 10),
              StaticText(AppText.strPassword),
              CustTextField(hide: true, controller: _password),
              SizedBox(height: 10),
              StaticText(AppText.strRePassword),
              CustTextField(hide: true, controller: _retype),
              SizedBox(height: 50),
              Visibility(
                visible: _isVisible,
                child: Text(
                  _strError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )
              ),
              SizedBox(height: 200),
              CustElevatedButton(text: AppText.strCreateAccount, onPressed: ()=> OnClick()),

          ],
        
        ),
      ),
    );
  }
  void OnClick() async {
    String fullname = _fullname.text;
    String username = _username.text;
    String password = _password.text;
    String retype = _retype.text;
    if ( password != retype) {
      handleError(AppText.strPasswordMismatch, 3 );
      return ;
    }

    if ( fullname.isEmpty || username.isEmpty || password.isEmpty || retype.isEmpty ){
      handleError(AppText.strMissingInformation, 3);
      return;
    }
    bool result = await ApiServices.instance.register(fullname, username, password);
    // result
    if (result){
      handleError(AppText.strRegisterSuccessfully, 5);
      Navigator.pop(context);
    } else {
      handleError(AppText.strRegisterFailed, 3);
      _fullname.clear();
      _username.clear();
      _password.clear();
      _retype.clear();
    }

  }
  void handleError(String strError, int time) {
    setState(() {
      _isVisible = true;
      _strError = strError;
    });
    Future.delayed(Duration(seconds: time) , (){
     setState(() {
      _isVisible = false;
     });
    });

  }

}