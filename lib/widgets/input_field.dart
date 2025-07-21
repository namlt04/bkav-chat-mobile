

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:untitled/models/message.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/widgets/file_preview.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
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
  bool showEmoijiPicker = false;
  bool showFilePicker = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: showFilePicker,
          child: Stack(
              children: [
                FilePreview(pickFileCallBack: pickFile, list : files ),
                Positioned(
                    top : 0,
                    right: 0,
                    child: IconButton(
                        onPressed:() {
                          setState(() {
                            showFilePicker = false;
                            files.clear();
                          });
                        },
                        icon: Icon(Icons.close)
                    )
                )
             ]
          ),
          replacement : SizedBox(),
        ),
        Center(
        child: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined),
                    onPressed: () async {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        showEmoijiPicker = !showEmoijiPicker;
                      });
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
                      widget.callAddMessage(messages);
                      _controller.clear();
                      files.clear();
                      setState(() {
                        showFilePicker = false;
                      });
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () async {
                       await pickFile();
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
                        if ( result != null) {
                          for (final asset in result) {
                            File? file = await asset.file;
                            if (file != null)
                              files.add(file);
                          }
                          // Goi them vao hien thi
                          setState(() {
                            showFilePicker = true;
                          });
                          files.clear();
                        }
                    }
                  ),
                ],
              )
            ),
            if (showEmoijiPicker)
              SizedBox(
                height: 200,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    _controller
                      ..text += emoji.emoji
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length),
                      );
                  },
                  config: Config(
                   emojiViewConfig: EmojiViewConfig(
                      emojiSizeMax: 32,
                      columns: 7,
                   )
                  ),
                ),
              )
          ],
        ),

      ),
                ]
    );
  }

  Future<void> pickFile() async {
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
      setState(() {
        showFilePicker = true;
      });
      files.clear();
    }
  }
}
