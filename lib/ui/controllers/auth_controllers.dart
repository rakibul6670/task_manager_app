import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_data_model.dart';

class AuthControllers {
  static final String accessTokenKey = "token";
  static final String _userModelKey = "userModel";

  static String? accessToken;
  static UserDataModel? userModel;

  //============================== Save User Data ==================
  static Future<void> saveUserData(
    String token,
    UserDataModel userDataModel,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(accessTokenKey, token);
    /*
        SharedPreferences কেবল primitive type (string, int, bool, double, stringList) সাপোর্ট করে।
        মানে তুমি যদি সরাসরি UserDataModel object দিতে চাও, সেটা পারবে না।
        কারণ object মেমোরি-তে থাকে, সেটা SharedPreferences-এ save করার মতো ডেটা টাইপ না।
        UserDataModel কে Map এ কনভার্ট করলে, সেটা একটা সাধারণ key-value ডেটা হয়ে যায়।
        যদি সরাসরি toString() করি তাহলে কী হবে?

      ধরি তুমি userDataModel.toString() করেছো →
      আউটপুট হবে এরকম:
         Instance of 'UserDataModel'
      এটা কোনো useful data না। আবার decode করে object বানানোর কোনো উপায় নেই।
      তাই toString() use করা যায় না।
    */
    await sharedPreferences.setString(
      _userModelKey,
      jsonEncode(
        userDataModel.toJson(),
      ), //-----string er modhhe object rakhar jonno seta ke toJson(map) kore aber string korchi
    );

    accessToken = token;
    userModel = userDataModel;
    final Logger logger = Logger();
    logger.i("Data save successful : $token");
  }

  //============================== Get User Data ==================
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(accessTokenKey);
    String? user = sharedPreferences.getString(_userModelKey);

    if (token != null) {
      accessToken = token;
      //
      // String user = sharedPreferences.getString(_userModelKey)!;
      // userModel = UserDataModel.fromJson(jsonDecode(user));
      if (user != null) {
        userModel = UserDataModel.fromJson(jsonDecode(user));
        Logger().i("User data loaded: ${userModel?.firstName}");
      } else {
        Logger().w("⚠️ No user data found in SharedPreferences");
      }
    }
  }

  //===================User Login check===================
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(accessTokenKey);
    return token != null;
  }

  static Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

     final Logger logger = Logger();
    logger.i("Cache Data clear successful");


  }
}
