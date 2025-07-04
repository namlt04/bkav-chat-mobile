
import 'package:untitled/models/message.dart' ;
import 'package:flutter/material.dart';
import 'package:untitled/services/isar_services.dart';
import 'package:untitled/widgets/bubble_message.dart' ;

class MessageList extends StatefulWidget{
  late List<Message> list =  [];
  final String friendId;
  MessageList({ Key? key,required this.friendId}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return MessageListState();
  }

}
class MessageListState extends State<MessageList>{
  @override
  void initState(){
    super.initState();
    _createMessageList();
  }
  Future<void> _createMessageList() async {
    widget.list = await IsarServices.instance.getMessages(widget.friendId);
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        final Message message = widget.list[index];
        return BubbleMessage(text: message.content, type: message.type);
      },

    );
  }

}