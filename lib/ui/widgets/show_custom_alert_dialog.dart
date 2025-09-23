import 'package:flutter/material.dart';

Future showCustomAlertDialog(context) async {
  return showDialog(
    useSafeArea: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title:  Icon(Icons.logout, size: 35),
        elevation: 4,
        content: Text(
          "Are your sure you want to \n logout ",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actionsAlignment:MainAxisAlignment.center,
        actions: [
          //-----------------------No Button for cancel logout---------------
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("No")
          ),

          //----------------------Yes Button ---------------
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Yes")
          )
        ],

      );
    },
  );
}
