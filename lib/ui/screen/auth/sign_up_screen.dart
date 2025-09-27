import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/ui/utils/validator.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/password_form_field.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/show_snack_bar_message.dart';

import '../../../data/utils/urls.dart';
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

  bool _signupProgressIndication = false;

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
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: Validator.validateEmail,
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
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: (value) =>
                        Validator.validateName(value, fieldName: "First name"),
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
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: (value) =>
                        Validator.validateName(value, fieldName: "Last name"),
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
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    validator: Validator.validatePhone,
                    controller: _mobileTEController,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),

                  SizedBox(height: 10),

                  //--------------Password Field-----------------
                  PasswordFormField(passwordController: _passwordTEController),

                  //-----------------------Login button ----------
                  SizedBox(height: 15),
                  Visibility(
                    visible: _signupProgressIndication == false,
                    replacement: LoadingProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapNextScreen,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                    ),
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
    if (_formKey.currentState!.validate()) {
      signUp();
    }
    // -------------------Go to Login screen--------
    // Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   AppRoutes.login,
    //   (predicate) => false,
    // );
  }

  //-------------------Sign up ----------------------------
  Future<void> signUp() async {
    //------------ when call this function then value true and show indicator---------
    _signupProgressIndication = true;
    setState(() {});

    //-------------request body -----------
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    //--------------Request to server for signup -----------------
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.signUpUrl,
      requestBody: requestBody,
    );

    //------------ when call this function then value false and off indicator---------
    _signupProgressIndication = false;
    setState(() {});

    if (response.isSuccess && response.responseBody["status"] == "success") {
      _clearControllerText();
      ShowSnackBarMessage.successMessage(
        context,
        "Sign up successful .Please log in",
      );
    } else {
      ShowSnackBarMessage.failedMessage(context, response.responseBody);
    }
  }

  void _clearControllerText() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
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
