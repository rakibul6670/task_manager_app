import 'package:flutter/material.dart';

class ShowSnackBarMessage {

  //-------------------success Snack bar -------------
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  successMessage(context,String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Column(children: [
          Icon(Icons.check_circle, color: Colors.green, size: 30),
          SizedBox(height: 5,),
          Text(message,style: TextStyle(
            color: Colors.white
          ),)
        ],)),
        elevation: 4,
        duration: Duration(seconds: 2),
      ),
    );
  }


  //-------------------success Snack bar -------------
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  failedMessage(context,String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Column(children: [
          Icon(Icons.question_mark_outlined, color: Colors.red, size: 30),
          SizedBox(height: 5,),
          Text(message,style: TextStyle(
              color: Colors.white
          ),)
        ],)),

        elevation: 4,
        duration: Duration(seconds: 3),

      ),
    );
  }


}
