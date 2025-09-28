import 'package:flutter/material.dart';



Future<void> changeStatusDialog(context, String taskStatus) async {
  return showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Update Task Status"),
        elevation: 4,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //---------------------New status--------
            ListTile(
              onTap: () {},
              title: Text("New"),
              trailing: taskStatus == "New"
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),

            //---------------------Progress status--------
            ListTile(
              onTap: () {},
              title: Text("Progress"),
              trailing: taskStatus == "Progress"
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),

            //---------------------Completed status--------
            ListTile(
              onTap: () {},
              title: Text("Completed"),
              trailing: taskStatus == "Completed"
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),

            //---------------------Progress status--------
            ListTile(
              onTap: () {},
              title: Text("Cancelled"),
              trailing: taskStatus == "Cancelled"
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          //-----------------------No Button for cancel logout---------------
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),

          // ----------------------Yes Button ---------------
          // ElevatedButton(onPressed:()=> _logout(context), child: Text("Yes")),
        ],
      );
    },
  );
}


