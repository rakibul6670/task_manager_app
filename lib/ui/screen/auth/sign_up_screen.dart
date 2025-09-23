import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screen/auth/login_screen.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

import '../../../routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //--------------------Form key for form validation ----------
  final _formKey = GlobalKey<FormState>();

  //----------------------- Text Editing Controller ---------
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
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
                  Text("Join With Us", style: textTheme.titleLarge),

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

                  //---------------First Name  Field ------------
                  TextFormField(
                    // validator: ,
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTEController,
                    decoration: InputDecoration(
                      hintText: "Enter your first name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 10),
                  //---------------Last Name Field ------------
                  TextFormField(
                    // validator: ,
                    textInputAction: TextInputAction.next,
                    controller: _lastNameTEController,
                    decoration: InputDecoration(
                      hintText: "Enter your last name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 10),
                  //---------------Mobile Number Field ------------
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
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
                    onPressed: _onTapNextScreen,
                    child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                  ),

                  SizedBox(height: 50),

                  //--------- Don't have an account and Sign up section -----
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: "Have account? ",
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _onTapLoginButton(),
                          ),
                        ],
                      ),
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

  //---------------Signup Button----------------------------
  void _onTapNextScreen() {
    // -------------------Go to Login screen--------
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (predicate) => false,
    );
  }

  void _onTapLoginButton() {
    // -------------------Go to Login screen--------
    //Navigator.pushNamed(context, AppRoutes.login);
    // -------------------Go to Login screen--------
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (predicate) => false,
    );
  }

  //------------------------Dispose all Controller --------------
  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
