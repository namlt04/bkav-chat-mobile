import 'package:flutter/material.dart';

class StaticText extends StatelessWidget{
  final String text;
  const StaticText(this.text);
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          SizedBox(width: 40),
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: const Color(0XFF000000),
            ),
          ),
        ]
    );
  }

}