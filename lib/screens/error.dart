import 'package:flutter/material.dart';
import 'package:untitled/widgets/cust_text.dart';
class ErrorNetworkScreen extends StatelessWidget{
  @override
  ErrorNetworkScreen();
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      child: Container(
        color: Colors.white,
        // padding: EdgeInsets.all(20),
        height: 200,
        child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child : const Icon(Icons.close)
                ),
              ),
              const SizedBox(height: 20),


              Padding(
                  padding: EdgeInsets.only(left : 34, right: 34),
                  child : CustText(
                    " Lỗi kết nối, vui lòng kiểm tra mạng ",
                    textAlign : TextAlign.center,
                  ),
                ),


              const SizedBox(height: 20),
              ElevatedButton(

                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    fixedSize: Size(113,37),
                    backgroundColor: Color(0xFF1C7FD9),
                  ),

                  child: const Text(
                      "Ok",
                      style: TextStyle(color: Colors.white),
                  )
              ),

            ]
        ),
      ),
    );
  }
  
}