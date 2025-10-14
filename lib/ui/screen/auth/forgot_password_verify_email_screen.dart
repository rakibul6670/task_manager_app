import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/screen/auth/forgot_password_verify_otp_screen.dart';
import 'package:task_manager_app/ui/utils/validator.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/show_snack_bar_message.dart';
import '../../../routes/app_routes.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});

  @override
  State<ForgotPasswordVerifyEmailScreen> createState() =>
      _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState
    extends State<ForgotPasswordVerifyEmailScreen> {
  //--------------------Form key for form validation ----------
  final _formKey = GlobalKey<FormState>();

  //----------------------- Text Editing Controller ---------
  final TextEditingController _emailTEController = TextEditingController();

  //----------------- email verify progress ----------------
  bool emailVerifyProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      //==========================Body Section =======================
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //------------------------Title --------------
                  SizedBox(height: 25),

                  //--------------------Title ------------------
                  Text("Your Email Address", style: textTheme.titleLarge),
                  SizedBox(height: 8),
                  //-----------------Subtitle ---------------
                  Text(
                    "A 6 digit verification pin will send to your \n email address ",
                    style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),

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

                  //-----------------------Login button ----------
                  SizedBox(height: 15),
                  Visibility(
                    visible: emailVerifyProgress == false,
                    replacement: LoadingProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapNextButton,
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
                            text: "Sign in",
                            style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _onTapSignInButton(),
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

  //--------------------Next screen with verify email ---------------------
  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      _emailVerify();
    }
  }

  //------------------------ Email verify and go to otp screen ------
  Future<void> _emailVerify() async {
    //========================= Progress show =================
    emailVerifyProgress = true;
    setState(() {});

    final response = await ApiCaller.getRequest(
      url: Urls.emailVerifyUrl(_emailTEController.text.trim()),
    );

    if(mounted){
      //========================= Progress off =================
      emailVerifyProgress = false;
      setState(() {});
    }

    if (response.isSuccess && response.responseBody["status"] == "success") {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordVerifyOtpScreen(
            email: _emailTEController.text.trim(),
          ),
        ),
        (predicate) => false,
      );
    } else {
      if(mounted){
        ShowSnackBarMessage.failedMessage(
          context,
          "Email not found. Please try again.",
        );
      }
    }
  }

  //------------------Back to Login screen ----------
  void _onTapSignInButton() {
    Navigator.pop(context);
  }

  //------------------------Dispose all Controller --------------
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
