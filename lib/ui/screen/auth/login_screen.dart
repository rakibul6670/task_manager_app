import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //--------------------Form key for form validation ----------
  final _formKey = GlobalKey<FormState>();

  //----------------------- Text Editing Controller ---------
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      //==========================Body Section =======================
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  //------------------------Title --------------
                  Text("Get Start With", style: textTheme.titleLarge),

                  SizedBox(height: 15),

                  //---------------Email Field ------------
                  TextFormField(
                    // validator: ,
                    textInputAction: TextInputAction.next,
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 10),

                  //--------------Password Field-----------------
                  TextFormField(
                    // validator: ,
                    textInputAction: TextInputAction.next,
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  //-----------------------Login button ----------
                  SizedBox(height: 15),
                  FilledButton(
                    onPressed: _onTapLoginButton,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                  ),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),

                        //----------------------Forgot password-----------
                        RichText(
                          text: TextSpan(
                            text: 'Forgot password',
                            style: TextStyle(color: Colors.grey),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _onTapForgotButton(),
                          ),
                        ),
                        SizedBox(height: 10),

                        //--------- Don't have an account and Sign up section -----
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  color: Colors.green,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _onTapSignUpButton(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //------------------Got To DashboardScreen --------------
  void _onTapLoginButton() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.dashboard,
      (predicate) => false,
    );
  }

  //---------------Forgot Button------------------------------
  void _onTapForgotButton() {
    //-------------------Go to forgot screen--------
    Navigator.pushNamed(context, AppRoutes.forgotPassword);
  }

  //---------------Signup Button-------------------------------
  void _onTapSignUpButton() {
    //-------------------Go to SignUp screen--------
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  //------------------------Dispose all Controller --------------
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
