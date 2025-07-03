import 'package:flutter/material.dart';

class CustTextField extends StatefulWidget{
  final TextEditingController controller;
  final bool hide;
  CustTextField({required this.hide,required this.controller});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustTextFieldState();
  }

}

class CustTextFieldState extends State<CustTextField>{

  late bool _local_hide;
  @override
  void initState() {
    _local_hide = widget.hide;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Center(

      child: SizedBox(
        width: 327,
        child: TextField(
          controller: widget.controller,
          obscureText: _local_hide,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

}