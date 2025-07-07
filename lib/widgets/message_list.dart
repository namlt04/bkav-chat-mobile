
import 'package:untitled/models/message.dart' ;
import 'package:flutter/material.dart';
import 'package:untitled/services/isar_services.dart';
import 'package:untitled/widgets/bubble_message.dart' ;
import 'package:untitled/services/api_services.dart';
class MessageList extends StatefulWidget{
  final List<Message> list;
  MessageList({ Key? key,required this.list}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return MessageListState();
  }

}
class MessageListState extends State<MessageList>{
  List<Message> list = [];
  @override
  void initState(){
    super.initState();
    list = widget.list;
  }
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final Message message = list[index];
        return BubbleMessage(message: message);
      },

    );
  }

}