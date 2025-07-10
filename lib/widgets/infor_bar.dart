

import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/models/user.dart';
class InforBar extends StatefulWidget{
  final User user;
  InforBar({Key? key, required this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InforBarStatus();
  }

}
class InforBarStatus extends State<InforBar>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      child: Row(
        children: [
          SizedBox(width : 12),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 24),
          Image.asset("assets/Images/user.png"),
          SizedBox(width : 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                  widget.user.Fullname ?? widget.user.username,
                  style: TextStyle( fontSize : 20, color: Colors.black, fontWeight: FontWeight.bold)),
              Text(
                  widget.user.isOnline ? 'Online' : 'Offline'
                  ,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontStyle:  FontStyle.italic)
              )
            ],
          )

        ],
      )
    );
  }
  
}