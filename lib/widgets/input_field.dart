

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:untitled/models/message.dart';
import 'package:untitled/services/api_services.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
class InputField extends StatefulWidget{
  final void Function(List<Message>) callAddMessage; 
  late final String friendId;
  InputField({Key? key,required this.friendId, required this.callAddMessage}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InputFieldState();
  }

}
class InputFieldState extends State<InputField>{
  List<File> files = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Nhập tin nhắn...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed : () async{
                List<Message> messages = await ApiServices.instance.sendMessage(_controller.text.trim(), widget.friendId, files);
                print('da bam gui');
                widget.callAddMessage(messages);
                _controller.clear();
                files.clear();
              }
            ),
            IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () async {
                  final PermissionState ps = await PhotoManager.requestPermissionExtend();
                  if (!ps.hasAccess){
                    PhotoManager.openSetting();

                  }
                  FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple : true);
                  if ( result != null){
                    List<PlatformFile> platformFiles = result.files;
                    for( PlatformFile item in platformFiles){
                      if ( item.path != null) {
                        File file = File(item.path!);
                        files.add(file);
                      }
                    }
                  }
              },

            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () async {
                  final List<AssetEntity>? result = await AssetPicker.pickAssets(
                    context,
                    pickerConfig: AssetPickerConfig(
                      maxAssets: 10,
                      requestType: RequestType.image,
                    ),
                  );
                  if ( result != null)
                  for (final asset in result) {
                    File? file = await asset.file;
                    if (file != null)
                      files.add(file);
                  }
              }
            ),
          ],
        )
      ),
    );
  }

}
