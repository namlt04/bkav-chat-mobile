
import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';
import 'dart:io';
import 'package:untitled/services/constants.dart';

class Contact extends StatelessWidget{
  final String name;
  late final String friendId;
  String? avatar;
  Contact({Key? key, required this.name, required this.friendId, this.avatar}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed( context,'/chat', arguments : friendId);
      },
      child: Container(
          height: 70,
          child: Row(
              children:[
                SizedBox(width: 14,),
                settingAvatar(avatar),
                SizedBox(width: 14),
                CustText(
                  name,
                  size: 20,
                )
              ]
          )
      ),
    );;
  }
  Widget settingAvatar(String? avatar ){
    // neu co avatar
    if (avatar != null)
      return ClipOval(
        child: Image.file(
            File('${AppUrl.path}${avatar}'),
            width: 64,
            height: 64,
            fit: BoxFit.cover
        )
      );
    return Image.asset('assets/Images/user.png');
  }

}