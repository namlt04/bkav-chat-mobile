import 'package:flutter/material.dart';

class StaticText extends StatelessWidget{
  final String text;
  const StaticText(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: const Color(0XFF000000),
            ),
          ),
          SizedBox(height:20)
        ]
    );
  }

}