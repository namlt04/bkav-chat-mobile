
import 'package:untitled/models/message.dart' ;
import 'package:flutter/material.dart';
import 'package:untitled/services/isar_services.dart';
import 'package:untitled/widgets/bubble_message.dart' ;
import 'package:untitled/services/api_services.dart';
class MessageList extends StatefulWidget{
  final String friendId;
  MessageList({ Key? key,required this.friendId}) : super(key : key);
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
    _createMessageList();
  }
  Future<void> _createMessageList() async {
    // khoi tao list
    final message = await IsarServices.instance.getMessages(widget.friendId);
    setState((){
      list = message; 
    });

  }

  Future<void> addMessage() async { 
    final newMessage = await ApiServices.instance.sendMessage(widget.friendId) ;
    setState(() { 
        list.addAll(newMessage);
    });
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final Message message = list[index];
        return BubbleMessage(text: message.content, type: message.type);
      },

    );
  }

}