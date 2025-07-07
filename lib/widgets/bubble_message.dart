import 'package:flutter/material.dart';
import 'package:untitled/models/message.dart';


class BubbleMessage extends StatefulWidget{
  final Message message;
  BubbleMessage({required this.message});
  @override
  State<StatefulWidget> createState() {
    return BubbleMessageState();
  }

}

class BubbleMessageState extends State<BubbleMessage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          if (widget.message.messageType == 0) Image.asset("assets/images/user.png"),
          // Container(
          Align(
              alignment: widget.message.messageType == 0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: SelectableText(
                    widget.message.content,
                    style: TextStyle(
                        fontSize: 16,
                        color:  widget.message.messageType == 0 ? Colors.red : Colors.black
                    )
                ),
                decoration: BoxDecoration(
                    color :  widget.message.messageType == 0 ? Color(0xFF20a090) : Color(0xff057ee1),
                    borderRadius: BorderRadius.only(
                      bottomLeft:Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      topLeft:   widget.message.messageType == 0 ? Radius.circular(0) : Radius.circular(10),
                      topRight:   widget.message.messageType == 0 ? Radius.circular(10) : Radius.circular(0),
                    )
                ),
              )

          ),

        ]
    );
  }

}