import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/routes/app_routes.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

import '../../../data/services/api_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/show_snack_bar_message.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {

  final String email;
  const ForgotPasswordVerifyOtpScreen({super.key, required this.email,});


  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  //--------------------Form key for form validation ----------
  final _formKey = GlobalKey<FormState>();

  //---------------otp controller -----------------------------
  late TextEditingController _otpController ;

  //----------------------- OTP verify progress ----------
  bool otpVerifyProgress = false;

  @override
  void initState() {
    super.initState();
    _otpController  = TextEditingController();
  }

  //-----------------Dispose controller -------------
  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    //final args = ModalRoute.of(context)!.settings.arguments as Map;
    //final email = args["email"];
    print(widget.email);
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
                  //------------------------Title --------------
                  SizedBox(height: 25),

                  //--------------------Title ------------------
                  Text("Enter your OTP", style: textTheme.titleLarge),
                  SizedBox(height: 8),
                  //-----------------Subtitle ---------------
                  Text(
                    "A 6 digit otp has been sent to your \n ${widget.email} email address ",
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),

                  SizedBox(height: 15),

                  //------------------OTP Field ------------------
                  PinCodeTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autoUnfocus: true,
                    appContext: context,
                    length: 6,
                    //--------i shouldn't controller use direct we can use onCompleted
                    controller: _otpController, //
                    // onChanged: (value) {
                    //   debugPrint("OTP Change :$value");
                    // },
                    // onCompleted: (value) {
                    //   debugPrint("Completed OTP: $value");
                    // },
                    keyboardType: TextInputType.number,
                    autoDismissKeyboard: true,
                    animationType: AnimationType.scale,

                    validator: (otp) {
                      if (otp == null || otp.isEmpty) {
                        return "Please enter your OTP";
                      } else if (otp.length < 6) {
                        return "OTP must be 6 digit";
                      }
                      return null;
                    },
                    // enablePinAutofill: ,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      activeColor: Colors.green,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.orange,
                    ),
                  ),

                  //-----------------------Login button ----------
                  SizedBox(height: 15),
                  Visibility(
                    visible: otpVerifyProgress == false,
                    replacement: LoadingProgressIndicator(),
                    child: FilledButton(
                      onPressed:() async{
                        if (_formKey.currentState!.validate()) {
                          await _otpVerify(widget.email);
                        }
                      },
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  //--------- Don't have an account and Sign up section -----
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: "Don't have and account? ",
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => _onTapSignUpButton(context),
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

  //=============================  otp verify and go to otp screen ==========================
  // Future<void> _otpVerify(String email) async {
  //   if (!mounted) return;
  //
  //   setState(() => otpVerifyProgress = true);
  //
  //   // --------------controller value ------
  //   final otpText = _otpController.text.trim();
  //
  //   // -
  //
  //   final response = await ApiCaller.getRequest(
  //     url: Urls.emailOTPUrl(email, int.parse(otpText)),
  //   );
  //   //
  //   // if (!mounted) return;
  //   setState(() => otpVerifyProgress = false);
  //
  //   if (response.isSuccess && response.responseBody?["status"] == "success") {
  //     // if (!mounted) return;
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       AppRoutes.login,
  //           (predicate) => false,
  //     );
  //   } else {
  //     // if (!mounted) return;
  //     ShowSnackBarMessage.failedMessage(
  //       context,
  //       response.errorMessage.toString(),
  //     );
  //   }
  // }

  Future<void> _otpVerify(String email) async {
    final int otp = int.parse(_otpController.text);
    //========================= Progress show =================
    otpVerifyProgress = true;
    setState(() {});

    final response = await ApiCaller.getRequest(
      url: Urls.emailOTPUrl(widget.email, otp),
    );

    // //========================= Progress off =================
    // otpVerifyProgress = false;
    // setState(() {});

    // if(mounted){
    //   otpVerifyProgress = false;
    //   setState(() {});
    // }

    if (response.isSuccess && response.responseBody["status"] == "success") {

      //========================= Progress off =================
      otpVerifyProgress = false;
      setState(() {});

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (predicate) => false,
      );
      // if(mounted){
      //
      // }

    } else {

      //========================= Progress off =================
      otpVerifyProgress = false;
      setState(() {});

      ShowSnackBarMessage.failedMessage(
        context,
        response.errorMessage.toString(),
      );
    }
  }

  //------------------Verify Function-----------------
  // void _onTapVerifyButton() {
  //
  // }

 // --------------Sign up screen navigate function -----
  void _onTapSignUpButton(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.signup,
      (predicate) => false,
    );
  }




}
