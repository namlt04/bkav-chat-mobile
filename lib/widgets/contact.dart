
import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';


class Contact extends StatelessWidget{
  final String name;
  late final String friendId;
  Contact({Key? key, required this.name, required this.friendId}) : super(key : key);
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
                Image.asset('assets/Images/user.png'),
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

}