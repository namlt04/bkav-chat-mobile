


import 'package:flutter/material.dart';
import 'package:untitled/widgets/widgets.dart';

class MessageList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MessageListState();
  }

}
class MessageListState extends State<MessageList>{
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        Message(text : "test",type:  "file"),
        Message(text : "test2",type:  "file"),
        Message(text : "test3",type:  "file"),
        Message(text : "test4",type:  "file"),
      ],
    );
  }

}