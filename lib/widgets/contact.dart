
import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';
import 'dart:io';
import 'package:untitled/services/constants.dart';
import 'package:untitled/models/user.dart';

class Contact extends StatelessWidget{
  final User user;

  Contact({Key? key, required this.user}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed( context,'/chat', arguments : user);
      },
      child: Container(
          height: 70,
          child: Row(
              children:[
                SizedBox(width: 14,),
                settingAvatar(user.avatar),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    CustText(
                      user.Fullname ?? user.username,
                      size: 20,
                    ),
                    SizedBox(
                      width: App.width * 0.6,
                      child: Text(
                        user.content,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,

                          ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    )
                  ],
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
            width: 10,
            height: 10,
            fit: BoxFit.cover
        )
      );
    return Image.asset('assets/Images/user.png');
  }


}