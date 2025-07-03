
import 'package:flutter/material.dart';
import 'package:untitled/widgets/contact_list.dart';
import 'package:untitled/widgets/cust_search_bar.dart';
import 'package:untitled/widgets/logo_text.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }

}
class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            LogoText(),
            CustSearchBar(),
        
            Expanded(
                child: ContactList()
            ),
          ],
        ),
      ),
    );
  }
}