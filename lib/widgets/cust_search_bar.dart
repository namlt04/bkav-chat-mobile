

import 'package:flutter/material.dart';



class CustSearchBar extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return CustSearchBarStatus();
  }
  
}
class CustSearchBarStatus extends State<CustSearchBar>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SearchBar(
      hintText: "Tim kiem",
      elevation: WidgetStatePropertyAll(0),
      leading: const Icon(Icons.search),
      trailing:[
        IconButton(
            icon: Icon(Icons.close),
            onPressed : () {
                print("Clear");
            }
        )
      ]

    );
  }
  
}