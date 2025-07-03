

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:untitled/screens/error_network_screen.dart';

class NetworkObserver{
  static bool _dialogShow = false;
  static void startNetworkMonitor(BuildContext context){
    Connectivity().onConnectivityChanged.listen( (_) async{
      bool _hasInternet = await _checkInternet();
      if ( !_hasInternet && !_dialogShow){
        _dialogShow = true;

        if ( context.mounted){
          showDialog(
              context: context,
              builder: (context) => ErrorNetworkScreen()
          ).then((_) {
            _dialogShow = false;
          }
          );
        }
      }
    });
  }
  static Future<bool> _checkInternet() async {
    try{
      var result = await InternetAddress.lookup("google.com");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;

    }
  }
}