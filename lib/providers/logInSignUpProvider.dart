import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LogInSignUpProvider with ChangeNotifier {
  static final LogInSignUpProvider provider = LogInSignUpProvider._internal();

  factory LogInSignUpProvider() {
    return provider;
  }
  LogInSignUpProvider._internal();

  bool isChecked = false;

  void updateIsCheck() {
    isChecked = !isChecked;
  }

  final GlobalKey<FormState> formKeyAuthenticationLogin =
      GlobalKey<FormState>();
  final logInPageEmailController = TextEditingController();
  final logInPagePasswordController = TextEditingController();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
}
