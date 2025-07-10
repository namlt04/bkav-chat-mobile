

import 'package:flutter/cupertino.dart';
import 'package:untitled/widgets/widgets.dart';
import 'package:untitled/services/services.dart';
import 'package:untitled/models/user.dart';

class ContactList extends StatefulWidget{
  final List<User> list;
  const ContactList({Key? key, required this.list}) : super(key: key);
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
        Text(
          'Danh sách hộp thoại',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, index) {
              final user = widget.list[index];
              return Contact(user : user);
            },
          ),
        ),

      ],
    );
  }

}