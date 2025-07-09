import 'package:flutter/material.dart';

class App{
  static late double width;
  static late double height;

}
class AppColor {
  static const Color warning = Color(0xFFEC4622);
  static const Color titleBar = Color(0xFFFFFFFF);

}
class AppText {
  static const String strLogo = 'BKAV Chat';
  static const String strAccount = 'Tài khoản';
  static const String strPassword = 'Mật khẩu';
  static const String strRePassword = 'Nhập lại mật khẩu';
  static const String strFullname = 'Tên hiển thị';
  static const String strRegister = 'Đăng ký';
  static const String strLogin = 'Đăng nhập';
  static const String strCreateAccount = 'Tạo tài khoản';
  static const String strAccountEmptyError = 'Tên đăng nhập không được để trống';
  static const String strPasswordEmptyError = 'Mật khẩu không được để trống';
  static const String strLoginFailed = 'Tên đăng nhập hoặc mật khẩu không chính xác';
  static const String strMissingInformation = 'Bạn điền thiếu thông tin';
  static const String strPasswordMismatch = 'Mật khẩu không khớp';
  static const String strRegisterFailed = 'Đăng ký không thành công';
  static const String strRegisterSuccessfully = 'Đăng ký thành công\nTrở lại màn hình đăng nhập sau 5s';
}

class AppUrl {
  static const String host = '10.0.2.2:8888';
  static late final String path;
  static late final String pathImages;
  static late final String pathAvatars;
  static late final String pathFiles;

}

class AppTmp {

}