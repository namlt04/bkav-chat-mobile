import 'package:flutter/material.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/widgets/message_list.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/models/message.dart';
import 'package:untitled/services/isar_services.dart';


class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatState();
  }

}
class ChatState extends State<Chat>{
  String friendId = '';
  late List<Message> list;
  void addNewMessage(List<Message> messages){
    setState((){
      list.addAll(messages);
    });
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    friendId = ModalRoute.of(context)!.settings.arguments as String;
    _initMessageList();
  }
  Future<void> _initMessageList() async {
    final List<Message>message = await ApiServices.instance.getMessageAll(friendId);
    setState((){
      list = message; 
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            InforBar(),
            Expanded(child: MessageList(list: list)),
            InputField(friendId: friendId, callAddMessage: addNewMessage)
          ],
        ),
      ),
    );
  }

}