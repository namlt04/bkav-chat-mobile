import 'package:flutter/material.dart';
import 'package:untitled/widgets/message_list.dart';
import 'package:untitled/widgets/widgets.dart';


class ChatScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatScreenState();
  }

}
class ChatScreenState extends State<ChatScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InforBar(),
        Expanded(child: MessageList()),
        InputField()
      ],
    );
  }

}