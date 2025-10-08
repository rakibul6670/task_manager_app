import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_manager_app/data/models/user_data_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/auth_controllers.dart';
import 'package:task_manager_app/ui/utils/validator.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/password_form_field.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/show_snack_bar_message.dart';

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

  bool loginProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      //==========================Body Section =======================
      body: ScreenBackground(
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
                  Text("Get Start With", style: textTheme.titleLarge),

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

                  //--------------Password Field-----------------
                  PasswordFormField(passwordController: _passwordTEController),

                  //-----------------------Login button ----------
                  SizedBox(height: 15),
                  Visibility(
                    visible: loginProgressIndicator == false,
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
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  //============================Login then go to dashboard ====================
  Future<void> _login() async {
    loginProgressIndicator = true;
    setState(() {});

    Map<String, dynamic> responseBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      requestBody: responseBody,
    );
    loginProgressIndicator = false;
    setState(() {});

    if (response.isSuccess && response.responseBody["status"] == "success") {

      UserDataModel model = UserDataModel.fromJson(
        response.responseBody["data"],
      );
      String token = response.responseBody["token"];

      //---------------------Local storage e data store ----------------

      await AuthControllers.saveUserData(token, model);

      Logger logger = Logger();
      logger.i("User Data Model : $model");

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.dashboard,
        (predicate) => false,
      );

      ShowSnackBarMessage.successMessage(context, "Login Successful");
    } else {
      ShowSnackBarMessage.failedMessage(context, response.responseBody);
    }
  }

  //---------------Forgot Button------------------------------------------------
  void _onTapForgotButton() {
    //-------------------Go to forgot screen------
    Navigator.pushNamed(context, AppRoutes.forgotPassword);
  }

  //---------------Signup Button-----------------------------------------------
  void _onTapSignUpButton() {
    //-------------------Go to SignUp screen--------
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  //------------------------Dispose all Controller ----------------------------
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
