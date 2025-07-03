import 'package:flutter/material.dart';

class CustElevatedButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;
  const CustElevatedButton({required this.text, required this.onPressed, super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: Size(327, 48),
            shape : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),
            backgroundColor: Color(0xFF6783E7)
        ),
        child: Text(
          text,
          style: TextStyle(
              color : Colors.white,
              fontWeight: FontWeight.w400,
              fontSize : 16
          ),
        )
    );
  }

}