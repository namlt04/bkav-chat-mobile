import 'package:flutter/material.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/widgets/message_list.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/models/message.dart';
import 'dart:collection';

class Chat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatState();
  }

}
class ChatState extends State<Chat>{
  String friendId = '';
  Queue<Message> queue = Queue() ;
  void addNewMessage(List<Message> messages){
    setState((){
      addMessage(messages);
    });
  }
  void addMessage(List<Message> messages){
    for (Message message in messages)
      queue.addFirst(message);
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    friendId = ModalRoute.of(context)!.settings.arguments as String;
    _initMessageList();
  }
  Future<void> _initMessageList() async {
    final List<Message>messages = await ApiServices.instance.getMessageAll(friendId);
    // List<Message> messages = [];
    // Message message = Message();
    // message.messageType = 0;
    // message.uuid = '1232313safdaf';
    // message.friendId = '123';
    // message.lastTime = 'sodafsa434324';
    // message.content = 'helo xin chaoasfaosifjaosdifjaoisfdjoaisjfosaidjfoiasdjfoiajsdfojdsafioajfoi';
    // message.link = '';
    // message.type = 0;
    // messages.add(message);
    //
    // Message message1 = Message();
    // message1.messageType =1;
    // message1.uuid = '1232313safdaf';
    // message1.friendId = '123';
    // message1.lastTime = 'sodafsa434324';
    // message1.content = 'helo xin chaohsadfkjsdafhkasjfdhaksjdfhsakdfdsalkfhasdklfhadslkhfakdshfakfhalkfdhakf';
    // message1.link = '';
    // message1.type = 0;
    // messages.add(message1);
    //
    // Message message2 = Message();
    // message2.messageType =1;
    // message2.uuid = '1232313safdaf';
    // message2.friendId = '123';
    // message2.lastTime = 'sodafsa434324';
    // message2.content = 'helo xin chao';
    // message2.link = '';
    // message2.type = 2;
    // messages.add(message2);
    setState((){
      // print(messages.length);
      addMessage(messages);
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
            Expanded(child: MessageList(list: queue.toList())),
            InputField(friendId: friendId, callAddMessage: addNewMessage)
          ],
        ),
      ),
    );
  }

}