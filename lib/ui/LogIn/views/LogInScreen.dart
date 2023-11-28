import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../colors.dart';
import '../../../components/loading_button.dart';
import '../../../data/user.dart';
import '../../../providers/logInSignUpProvider.dart';
import '../text_fields/text_fields.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenScreenState();
}

class _LogInScreenScreenState extends State<LogInScreen> {
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LogInSignUpProvider>();
    double heightBetweenFields = 8.0;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        height: 700,
        width: _screenWidth,
        child: Center(
          child: Form(
            key: provider.formKeyAuthenticationLogin,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  const Text(
                    "Sign In",
                    style: TextStyle(
                      color: DSColors.darkPurple,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _screenWidth > 550
                      ? SizedBox(
                          width: 500,
                          child: Column(
                            children: [
                              SizedBox(
                                height: heightBetweenFields,
                              ),
                              EmailController(
                                hint: 'Email',
                                iconData: Icons.person,
                                emailController:
                                    provider.logInPageEmailController,
                              ),
                              SizedBox(
                                height: heightBetweenFields,
                              ),
                              PasswordController(
                                hint: 'Password',
                                iconData: Icons.person,
                                passwordController:
                                    provider.logInPagePasswordController,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: heightBetweenFields,
                            ),
                            EmailController(
                              hint: 'Email',
                              iconData: Icons.person,
                              emailController:
                                  provider.logInPageEmailController,
                            ),
                            SizedBox(
                              height: heightBetweenFields,
                            ),
                            PasswordController(
                              hint: 'Password',
                              iconData: Icons.person,
                              passwordController:
                                  provider.logInPagePasswordController,
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  LoadingButton(
                    buttonText: 'Sign In',
                    goNextScreen: () async {
                      UserController().searchUser(
                        provider.logInPageEmailController.text,
                        provider.logInPagePasswordController.text,
                        context,
                      );
                      _controller.reset();
                    },
                    controller: _controller,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
