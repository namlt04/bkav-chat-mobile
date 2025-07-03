

import 'package:flutter/material.dart';

class LogoText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
          "BKAV Chat",
          style : TextStyle(
            color: Color(0xFF146AE0),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
      ),
    );
  }

}