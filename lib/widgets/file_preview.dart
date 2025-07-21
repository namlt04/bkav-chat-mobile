

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:untitled/widgets/widgets.dart';


 class FilePreview extends StatefulWidget{
   final Future<void> Function() pickFileCallBack;
   final List<File> list;
   FilePreview({required this.list, required this.pickFileCallBack});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return FilePreviewState();
  }

}

class FilePreviewState extends State<FilePreview>{
  List<File> list = [];

  @override
  initState(){
    super.initState();
    list = widget.list;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SizedBox(
      height: 150 ,
      child:
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length + 1, // so item cua listview
          itemBuilder: (BuildContext context, int index) {
              if ( index == 0)
                return IconButton(
                    onPressed: () async {
                      // Mo bang chon file
                      await widget.pickFileCallBack();
                    },
                    icon: Icon(Icons.add)
                );
              else {
                  File file = list[index - 1];
                  String fullpath = file.path;
                  String nameFile = basename(fullpath);
                  String ext = extension(nameFile);
                  if ( ext == '.jpg' || ext == '.png' || ext == '.jpeg'){
                    return Center(
                      child: Stack(
                        children: [
                          Container(
                          width: 70,
                          height: 70,
                          padding: EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          child: Image.file(
                              file,
                              fit: BoxFit.cover,
                              width:70,
                              height : 70,
                          ),
                        ),

                           Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap : (){
                                    setState(() {
                                      list.removeAt(index - 1);
                                    });
                                  },
                                  child: Container(
                                    width : 24,
                                    height :24,
                                    decoration: BoxDecoration(
                                      shape : BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(Icons.close)

                                    ),
                                )
                                )

                        ]
                      ),
                    );
                  }
                  else {

                    return Center(
                      child: Stack(
                        children: [
                          Container(
                          width: 200,
                          height: 70,

                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.insert_drive_file,
                                size: 70,

                              ),

                              Expanded(
                                child: Text(
                                  nameFile,
                                  style: TextStyle(
                                      fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                          Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap : (){
                                  setState(() {
                                    list.removeAt(index - 1);
                                  });
                                },
                                child: Container(
                                    width : 24,
                                    height :24,
                                    decoration: BoxDecoration(
                                      shape : BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Icon(Icons.close)

                                ),
                              )
                          )
                        ]
                      ),
                    );
                  }
              }
          },

        ),
    );
  }

}

