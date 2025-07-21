

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';

class FilePreview extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return FilePreviewState();
  }

}

class FilePreviewState extends State<FilePreview>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<File> list = [];

    @override
    initState(){

    }
    return SizedBox(
      height: 200 ,
      child:
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10, // So item toi da cua listview
          itemBuilder: (BuildContext context, int index) {
              if ( index == 0)
                return IconButton(
                    onPressed: () {
                      // Mo bang chon file
                    },
                    icon: Icon(Icons.add)
                );
              else {
                  File file = list[index - 1];
                  String fullpath = file.path;
                  String nameFile = basename(fullpath);
                  String ext = extension(nameFile);
                  if ( ext == '.jpg' || ext == '.png' || ext == 'jpeg'){
                      return /*  ve hinh anh*/;
                  }
                  else {

                    return /* */ vẽ te
                  }
              }
          },

        ),
    );
  }

}

