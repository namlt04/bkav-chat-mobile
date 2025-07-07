

import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';

class InforBar extends StatefulWidget{
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
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          Expanded(child: Image.asset("assets/images/user.png")),
          Column(
            children: [
              const CustText(
                "text,",
                size : 20
              ),
              Text("dang hoat dong", style: TextStyle( color: Colors.grey, fontStyle:  FontStyle.italic),)
            ],
          )

        ],
      )
    );
  }
  
}