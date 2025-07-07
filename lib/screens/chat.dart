import 'package:flutter/material.dart';
import 'package:untitled/widgets/message_list.dart';
import 'package:untitled/widgets/widgets.dart';


class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatState();
  }

}
class ChatState extends State<Chat>{
  late final String friendId;
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    friendId = ModalRoute.of(context)!.settings.arguments as String;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        InforBar(),
        Expanded(child: MessageList(friendId: friendId)),
        InputField(friendId: friendId,)
      ],
    );
  }

}