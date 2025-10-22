import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/routes/app_routes.dart';
import 'package:task_manager_app/ui/screen/auth/recovery_reset_password_screen.dart';
import 'package:task_manager_app/ui/widgets/loading_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';

import '../../../data/services/api_caller.dart';
import '../../../data/utils/urls.dart';
import '../../widgets/show_snack_bar_message.dart';

class ForgotPasswordVerifyOtpScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordVerifyOtpScreen({super.key, required this.email});

  @override
  State<ForgotPasswordVerifyOtpScreen> createState() =>
      _ForgotPasswordVerifyOtpScreenState();
}

class _ForgotPasswordVerifyOtpScreenState
    extends State<ForgotPasswordVerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool otpVerifyProgress = false;
  String _enteredOtp = ""; // <- stores OTP safely, not with controller

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text("Enter your OTP", style: textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    "A 6 digit OTP has been sent to your\n${widget.email}",
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 20),


                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    autoDismissKeyboard: true,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.scale,
                    onChanged: (value) {
                      // OTP input without controller
                      _enteredOtp = value;
                    },
                    onCompleted: (value) {
                      // OTP input without controller
                      _enteredOtp = value;
                    },
                    validator: (otp) {
                      if (otp == null || otp.isEmpty) {
                        return "Please enter your OTP";
                      } else if (otp.length < 6) {
                        return "OTP must be 6 digits";
                      }
                      return null;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(7),
                      activeColor: Colors.green,
                      inactiveColor: Colors.black,
                      selectedColor: Colors.orange,
                    ),
                  ),

                  const SizedBox(height: 15),

                  //  Verify Button
                  Visibility(
                    visible: !otpVerifyProgress,
                    replacement: const LoadingProgressIndicator(),
                    child: FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _otpVerify(widget.email, _enteredOtp);
                        }
                      },
                      child: const Text(
                        "Verify",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  //  Signup link
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign up",
                            style: const TextStyle(
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

  //  OTP verify function
  Future<void> _otpVerify(String email, String otpText) async {
    if (otpText.isEmpty || otpText.length != 6) {
      ShowSnackBarMessage.failedMessage(context, "Enter a valid 6-digit OTP");
      return;
    }

    int otp = int.tryParse(otpText) ?? 0;

    otpVerifyProgress = true;
    if (mounted) setState(() {});

    try {
      final response = await ApiCaller.getRequest(
        url: Urls.emailOTPUrl(email, otp),
      );

      if (!mounted) return;

      otpVerifyProgress = false;
      if (mounted) setState(() {});

      if (response.isSuccess &&
          response.responseBody["status"] == "success") {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context)=> RecoveryResetPasswordScreen(email: email, otp: otp.toString())),
              (predicate) => false,
        );
      } else {
        if (!mounted) return;
        ShowSnackBarMessage.failedMessage(
          context,
          response.errorMessage?.toString() ?? "OTP verification failed",
        );
      }
    } catch (e) {
      if (mounted) {
        otpVerifyProgress = false;
        setState(() {});
        ShowSnackBarMessage.failedMessage(context, e.toString());
      }
    } finally {
      if (mounted) {
        otpVerifyProgress = false;
        setState(() {});
      }
    }
  }

  void _onTapSignUpButton(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.signup,
          (predicate) => false,
    );
  }
}