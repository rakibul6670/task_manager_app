import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utils/validator.dart';

class PasswordFormField extends StatefulWidget {

  final TextEditingController passwordController;
  final String? Function(String?)? validator;

  const PasswordFormField({
    super.key,
     this.validator,
    required this.passwordController,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: widget.validator?? Validator.validatePassword,
      textInputAction: TextInputAction.next,
      controller: widget.passwordController,
      obscureText: _hidePassword,
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.grey),
        suffixIcon: GestureDetector(
          onTap: () {
            _hidePassword = !_hidePassword;
            setState(() {});
          },
          child: _hidePassword
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
    );
  }
}
