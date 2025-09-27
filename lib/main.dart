import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/ui/controllers/auth_controllers.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  //======================Bar bar token access na kore app open hole ekbar korbe ---------
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AuthControllers.accessToken =
      sharedPreferences.getString(AuthControllers.accessTokenKey) ?? " ";

  runApp(TaskManagerApp());
}
