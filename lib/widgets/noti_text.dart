


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotiText extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return NotiTextState();
  }
}


class NotiTextState extends State<NotiText> {
  bool _isVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void visibleText(){
    setState(){
      _isVisible = true;
    }
    Future.delayed(Duration(seconds: 3), (){
      setState(() {
        _isVisible = false;
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Visibility(
        visible: _isVisible,
        child: Text(
           'Hello',
          style: TextStyle(
            color: Colors.red
          ),
        )
    );
  }

}