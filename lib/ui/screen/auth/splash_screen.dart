import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_app/ui/controllers/auth_controllers.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import '../../../routes/app_routes.dart';
import '../../utils/assets_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  //------------------------Next Screen e jawyer jonno function ---------------
  Future _moveToNextScreen() async {
    //-----------------2 seconds wait korbe splash screen e ----------
    await Future.delayed(Duration(seconds: 2), () async {
      final bool isLogged = await AuthControllers.isUserLoggedIn();
      final Logger logger = Logger();
      logger.i("Is Logged : $isLogged");
      
      if (isLogged) {
        // -------------------Go to Login screen--------
        Navigator.pushNamedAndRemoveUntil(
          (context),
          AppRoutes.dashboard,
          (predicate) => false,
        );
      } else {
        // -------------------Go to Login screen--------
        Navigator.pushNamedAndRemoveUntil(
          (context),
          AppRoutes.login,
          (predicate) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //============================Body Section =========================
      body: ScreenBackground(
        child: Center(
          //----------------------Splash screen logo---------------
          child: SvgPicture.asset(AssetsPath.logoSvg, height: 50),
        ),
      ),
    );
  }
}
