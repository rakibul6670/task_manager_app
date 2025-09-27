import 'package:flutter/material.dart';
import 'package:task_manager_app/routes/app_routes.dart';
import 'package:task_manager_app/ui/screen/add_task_screen.dart';
import 'package:task_manager_app/ui/screen/auth/forgot_password_verify_email_screen.dart';
import 'package:task_manager_app/ui/screen/auth/forgot_password_verify_otp_screen.dart';
import 'package:task_manager_app/ui/screen/auth/sign_up_screen.dart';
import 'package:task_manager_app/ui/screen/auth/splash_screen.dart';
import 'package:task_manager_app/ui/screen/cancelled_task_screen.dart';
import 'package:task_manager_app/ui/screen/completed_task_screen.dart';
import 'package:task_manager_app/ui/screen/main_nav_bar_holder_screen.dart';
import 'package:task_manager_app/ui/screen/progress_task_screen.dart';
import 'package:task_manager_app/ui/screen/update_profile_screen.dart';
import '../ui/screen/auth/login_screen.dart';

class AppPages {
  //---------------------All Pages list -----------
  static Map<String, Widget Function(BuildContext)> routes = {
    //--------------------------Auth Screen ---------------------
    AppRoutes.initialRoute: (context) => SplashScreen(),
    AppRoutes.login: (context) => LoginScreen(),
    AppRoutes.signup: (context) => SignUpScreen(),
    AppRoutes.forgotPassword: (context) => ForgotPasswordVerifyEmailScreen(),
    AppRoutes.forgotPasswordOtp: (context) => ForgotPasswordVerifyOtpScreen(),

    //----------------------Navigation bar screen --------------
    AppRoutes.dashboard: (context) => MainNavBarHolderScreen(),
    AppRoutes.progressTask: (context) => ProgressTaskScreen(),
    AppRoutes.completedTask: (context) => CompletedTaskScreen(),
    AppRoutes.cancelledTask: (context) => CancelledTaskScreen(),

    //-------------------Add and Update task screen ----------------
    AppRoutes.addTask: (context) => AddTaskScreen(),

    //--------------------Update profile ------------------------
    AppRoutes.updateProfile: (context) => UpdateProfileScreen(),
  };
}
