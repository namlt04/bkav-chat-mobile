
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
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      reverse: true, // day la reveser true
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        final Message message = widget.list[index];
        bool _drawAvatar = false;
        // if ( index + 1 < widget.list.length ) {
        //   Message messageNext = widget.list[index + 1];
        //   if ( messageNext.messageType == 0)
        //     _drawAvatar = true;
        // }
        if ( index - 1 >= 0 ){
          Message messageNext = widget.list[index - 1];
          if ( messageNext.messageType == 1)
            _drawAvatar = true;
        }
        return BubbleMessage(message: message,drawAvatar:  _drawAvatar);
      },

    );
  }

}