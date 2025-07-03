import 'package:flutter/material.dart';

class CustText extends StatelessWidget{
  final String text;
  final TextAlign textAlign;
  final Color color;
  final double size;
  const CustText(
      this.text,{
        this.textAlign = TextAlign.start,
        this.color = const Color(0xFF000000),
        this.size = 16.0,
        super.key
      });
  // Tên hiển thị
  // Tài khoản
  // Mật khẩu
  // Nhập lai mat khau
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w400,
          color: color,
      ),

    );
  }

}