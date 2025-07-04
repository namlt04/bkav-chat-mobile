import 'package:flutter/material.dart';



class BubbleMessage extends StatefulWidget{

  final bool isMe;
  final String name;
  final String text;
  final int type;
  BubbleMessage({this.isMe = true, this.name = "THANH NAM", required this.text, required this.type, super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BubbleMessageState();
  }

}

class BubbleMessageState extends State<BubbleMessage>{
  late final bool isMe ;
  late final String name;
  late final String text;
  late final int type;

  @override
  void initState() {
    text = widget.text;
    type = widget.type;
    isMe = widget.isMe;
    name = widget.name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          if (!isMe) Image.asset("assets/images/user.png"),
          // Container(
          Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 200,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: SelectableText(
                    text,
                    style: TextStyle(
                        fontSize: 16,
                        color: isMe ? Colors.white : Colors.black
                    )
                ),
                decoration: BoxDecoration(
                    color : isMe ? Color(0xFF20a090) : Color(0xFFf2f7fb),
                    borderRadius: BorderRadius.only(
                      bottomLeft:Radius.circular(10),
                      bottomRight:  Radius.circular(10),
                      topLeft:  isMe ? Radius.circular(0) : Radius.circular(10),
                      topRight:  isMe ? Radius.circular(10) : Radius.circular(0),
                    )
                ),
              )

          ),

        ]
    );
  }

}