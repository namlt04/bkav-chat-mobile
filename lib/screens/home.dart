
import 'package:flutter/material.dart';
import 'package:untitled/widgets/contact_list.dart';
import 'package:untitled/widgets/cust_search_bar.dart';
import 'package:untitled/widgets/logo_text.dart';
import 'package:untitled/services/services.dart';
class Home extends StatefulWidget{
  Home({Key? key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }

}
class HomeState extends State<Home>{
  List<User> list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFriends();
  }
  Future<void> _loadFriends() async {
    list = await ApiServices.instance.getFriend();
    setState(() {}); // Cập nhật lại UI sau khi có dữ liệu
  }
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
                child: ContactList(list : list)
            ),
          ],
        ),
      ),
    );
  }
}