

import 'package:flutter/material.dart';

class InputField extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InputFieldState();
  }

}
class InputFieldState extends State<StatefulWidget>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.emoji_emotions_outlined),
              onPressed: (){
                print("emoji");
              }
            ),
            Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Nhập tin nhắn...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed : (){
                print("send");
              }
            ),
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: (){
                print("attach_file");
              },
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: (){
                print("photo");
              }
            ),
          ],
        )
      ),
    );
  }

}
