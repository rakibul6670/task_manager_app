import 'package:flutter/material.dart';
import 'package:task_manager_app/routes/app_pages.dart';
import 'package:task_manager_app/routes/app_routes.dart';

class TaskManagerApp extends StatelessWidget {
  final bool isLoggedIn;

  const TaskManagerApp({super.key, required this.isLoggedIn});
  
  /*
  It creates a static GlobalKey for your app’s Navigator.
   You can then use it to navigate without context, 
   like in services, providers, or API callbacks.
  */
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //colorSchemeSeed: Colors.green,
        //------------------------Bottom Navigation Bar -----------------------
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black38,
        ),

        //------------Text theme ---------------
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
        ),

        //-----------------FormTextField theme style --------
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hoverColor: Colors.white,
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),

          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),

        //---------------------Filled button theme style ---------
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      title: 'Smart Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn
          ? AppRoutes.dashboard
          : AppRoutes.login,
      routes: AppPages.routes,
    );
  }
}
