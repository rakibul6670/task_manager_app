import 'package:flutter/material.dart';
import 'package:task_manager_app/routes/app_routes.dart';
import 'package:task_manager_app/ui/controllers/auth_controllers.dart';

Future showLogOutDialog(context) async {
  return showDialog(
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Icon(Icons.logout, size: 35),
        elevation: 4,
        content: Text(
          "Are your sure you want to \n logout ",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
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

          //----------------------Yes Button ---------------
          ElevatedButton(onPressed:()=> _logout(context), child: Text("Yes")),
        ],
      );
    },
  );
}

//=================Logout ==================
Future<void> _logout(context) async {
  await AuthControllers.clearUserData();
  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (predicate) => false);
}
