import 'package:flutter/material.dart';
import 'package:untitled/models/message.dart';
import 'dart:io';
import 'package:untitled/services/constants.dart';
import 'package:untitled/services/api_services.dart';
class BubbleMessage extends StatefulWidget{
  final Message message;
  final bool drawAvatar;
  final bool drawTick;
  BubbleMessage({required this.message, required this.drawAvatar, required this.drawTick});
  @override
  State<StatefulWidget> createState() {
    return BubbleMessageState();
  }

}

class BubbleMessageState extends State<BubbleMessage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
          // if (widget.message.messageType == 0) Image.asset("assets/images/user.png"),
          // Container(
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: widget.message.messageType == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  if (widget.message.messageType == 0 )
                   //  Padding(
                   //    padding: widget.drawAvatar ?  EdgeInsets.only(left: 8) : EdgeInsets.only(left: 38),
                   //  child : widget.drawAvatar ?  Image.asset('assets/Images/user.png', width: 30, height: 30 ) : SizedBox.shrink() ,
                   // ),
                  SizedBox(
                   width : 38,
                   child : widget.drawAvatar ? Image.asset('assets/Images/user.png', width: 30, height: 30) : SizedBox.shrink(),
                  ),
                  Padding (
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top : 5,
                        bottom: 5
                      ),
                  child : Align(

                      // alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: App.width * 0.55,
                        ),
                        padding: EdgeInsets.all(5),
                        child: buildWidgetContent(),

                        decoration: BoxDecoration(
                              color :  widget.message.messageType == 0 ? Color(0xFF20a090) : Color(0xff057ee1),
                              borderRadius: BorderRadius.circular(10),
                        ),
                      )


                  )),

                ],
                  ),
               if (widget.drawTick)
                 Row(
                   mainAxisAlignment: widget.message.messageType == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                   children: [
                     Icon(
                       widget.message.isSend == 0 ? Icons.done : Icons.done_all
                     )
                   ],
                 )
            ],
          );
    }
  Widget buildWidgetContent(){
    print('Da duoc goi toi buildWidgetContent');
    switch(widget.message.type){
      case 0:
        return SelectableText(
                widget.message.content,
                style: TextStyle(
                          fontSize: 16,
                          color: widget.message.messageType == 0 ? Colors.white : Colors.black
                        ),
                textAlign: widget.message.messageType == 0 ? TextAlign.left : TextAlign.right,
                );
      case 1:
        return
          Image.file(
              File('${AppUrl.path}${widget.message.link}'),
              width: widget.message.width.toDouble(),
              height: widget.message.height.toDouble(),
              fit: BoxFit.contain,
          );
      case 2:
        return GestureDetector(
          onTap : () async {
            await ApiServices.instance.getResource(widget.message.link);
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: App.width * 0.55,
            ),
            child: Row(
              // row luon co gang chiem max width
              mainAxisSize:  MainAxisSize.min,
              children: [
                Icon(Icons.download),
                Flexible(
                  child: Text(
                  widget.message.content,
                  softWrap: true,
                  style: TextStyle(
                  fontSize: 16,
                  color: widget.message.messageType == 0 ? Colors.white : Colors.black
                  ),
                  textAlign: widget.message.messageType == 0 ? TextAlign.left : TextAlign.right,
                  ),
                )
                // Text(
                //     widget.message.content,
                //     textAlign: widget.message.messageType == 0 ? TextAlign.left : TextAlign.right,
                // ),
              ],
            ),
          ),
        );
    }
    return Text('Heloo');

  }

}