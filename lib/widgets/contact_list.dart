

import 'package:flutter/cupertino.dart';
import 'package:untitled/widgets/widgets.dart';


class ContactList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContactListState();
  }

}
class ContactListState extends State<ContactList>{

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const CustText("Danh sach hop thoai", size: 20),
        Expanded(
          child: ListView(
              children: [
                Contact("Le Thanh Nam"),
                Contact("Bui Mai Quynh"),
                Contact("Le Thanh Nam Quynh"),
                Contact("Bui Mai Quynh"),
                Contact("Le Thanh Nam Quynh"),
                Contact("Bui Mai Quynh"),

              ]
          ),
        ),

      ],
    );
  }

}