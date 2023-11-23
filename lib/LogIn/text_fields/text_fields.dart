import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class EmailController extends StatelessWidget {
  final TextEditingController emailController;
  final String hint;
  final IconData iconData;
  const EmailController(
      {Key? key,
      required this.emailController,
      required this.hint,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            validator: (emailController) =>
                !EmailValidator.validate(emailController!)
                    ? 'Invalid Email'
                    : null,
            controller: emailController,
            cursorColor: Colors.indigoAccent,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(
                iconData,
                color: DSColors.darkPurple,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: DSColors.darkPurple,
                ),
                onPressed: () => emailController.clear(),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ),
    );
  }
}

class PasswordController extends StatefulWidget {
  final TextEditingController passwordController;
  final String hint;
  final IconData iconData;
  const PasswordController(
      {Key? key,
      required this.passwordController,
      required this.hint,
      required this.iconData})
      : super(key: key);

  @override
  State<PasswordController> createState() => _PasswordControllerState();
}

class _PasswordControllerState extends State<PasswordController> {
  bool passwordIsHidden = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            validator: (passwordController) {
              if (passwordController!.trim().length < 6) {
                return "Your password must contain at least 6 characters";
              } else {
                return null;
              }
            },
            controller: widget.passwordController,
            cursorColor: Colors.indigoAccent,
            obscureText: passwordIsHidden,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              prefixIcon: Icon(
                widget.iconData,
                color: DSColors.darkPurple,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    passwordIsHidden = !passwordIsHidden;
                  });
                },
                child: Icon(
                  passwordIsHidden ? Icons.visibility : Icons.visibility_off,
                  color: DSColors.darkPurple,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ),
    );
  }
}
