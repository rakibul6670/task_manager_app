import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../data/models/user_data_model.dart';
import '../../../data/services/api_caller.dart';
import '../../../data/utils/urls.dart';
import '../../../routes/app_routes.dart';
import '../../controllers/auth_controllers.dart';
import '../../utils/validator.dart';
import '../../widgets/loading_progress_indicator.dart';
import '../../widgets/password_form_field.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/show_snack_bar_message.dart';

class RecoveryResetPasswordScreen extends StatefulWidget {

  final String email;
  final String otp;
  const RecoveryResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<RecoveryResetPasswordScreen> createState() => _RecoveryResetPasswordScreenState();
}

class _RecoveryResetPasswordScreenState extends State<RecoveryResetPasswordScreen> {

  //----------------- controller -------------
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  bool changePasswordPIndicator = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body:  ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  //------------------------Title --------------
                  Text("Change your password", style: textTheme.titleLarge),

                  SizedBox(height: 15),

                  //-------------- Password Field-----------------
                  PasswordFormField(
                    hintText: "Enter your new password",
                    passwordController: _passwordTEController,),
                  SizedBox(height: 10),

                  //-------------- Confirm Password Field-----------------
                  PasswordFormField(
                      hintText: "Enter your confirm password",
                      passwordController: _confirmPasswordTEController,
                      validator: (value){
                        return Validator.validateConfirmPassword(value, _passwordTEController.text);


                      }

                  ),

                  //-----------------------Login button ----------
                  SizedBox(height: 15),
                  Visibility(
                    visible: changePasswordPIndicator == false,
                    replacement: LoadingProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapLoginButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                    ),
                  ),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),


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
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  //============================Login then go to dashboard ====================
  Future<void> _login() async {
  changePasswordPIndicator = true;
    setState(() {});

    Map<String, dynamic> responseBody = {
      "email": widget.email,
      "OTP":widget.otp,
      "password": _passwordTEController.text.trim(),
    };

  // {
  //   "email":"email@gmail.com",
  //   "OTP": "190828",
  //   "password":"12212221"
  // }




    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.recoverResetPassword,
      requestBody: responseBody,
    );
    changePasswordPIndicator = false;
    setState(() {});

    if (response.isSuccess && response.responseBody["status"] == "success") {
      // Logger logger = Logger();
      // logger.i("Response Body : ${responseBody.runtimeType}");
      // UserDataModel model = UserDataModel.fromJson(
      //   response.responseBody["data"],
      // );
      // String token = response.responseBody["token"];
      //
      // //---------------------Local storage e data store ----------------
      //
      // await AuthControllers.saveUserData(token, model);
      //
      //
      // logger.i(" Change User Data Model : $model");

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (predicate) => false,
      );

      ShowSnackBarMessage.successMessage(context, "password change Successful");
    } else {
      ShowSnackBarMessage.failedMessage(context, response.responseBody);
    }
  }



  //---------------Signup Button-----------------------------------------------
  void _onTapSignUpButton() {
    //-------------------Go to SignUp screen--------
    Navigator.pushNamed(context, AppRoutes.signup);
  }
}
