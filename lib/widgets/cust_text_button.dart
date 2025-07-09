import 'package:flutter/material.dart';

class CustTextButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;
  const CustTextButton({required this.text,required this.onPressed, super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      onPressed: onPressed,
      child: Text(
          text,
          style: TextStyle(
           fontSize: 20,
          ),
      )
    );
  }

}