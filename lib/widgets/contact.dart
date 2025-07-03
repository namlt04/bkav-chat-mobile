
import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';


class Contact extends StatelessWidget{
  // statefullWidget, ( hiển thị trạng thái online, offline )
  final String name;
  Contact(this.name);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Clicked $name");
      },
      child: Container(
          height: 70,
          child: Row(
              children:[
                Image.asset('assets/images/user.png'),
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