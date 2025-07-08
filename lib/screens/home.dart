
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
    App.width = MediaQuery.of(context).size.width;
    App.height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 5,),
            LogoText(),
            SizedBox(height: 10),
            CustSearchBar(),
            SizedBox(height : 10),
            Expanded(
                child: ContactList(list : list)
            ),
          ],
        ),
      ),
    );
  }
}