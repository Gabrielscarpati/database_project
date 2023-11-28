import 'package:database_project/colors.dart';
import 'package:database_project/components/ds_standard_text.dart';
import 'package:database_project/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../components/DSTextFIeld.dart';
import '../../components/DS_app_bar.dart';
import '../../components/loading_button.dart';
import '../../components/snackBar.dart';
import '../../data/authetication.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DSAppBar(
          title: 'Create a new user',
          isBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  title: 'First name',
                  texFieldController: lastName,
                  hint: 'Enter first name',
                  validator: (String) {
                    return '';
                  },
                ),
                CustomTextField(
                  title: 'Last name',
                  texFieldController: firstName,
                  hint: 'Enter last name',
                  validator: (String) {
                    return '';
                  },
                ),
                CustomTextField(
                  title: 'Email',
                  texFieldController: email,
                  hint: 'Enter email',
                  validator: (String) {
                    return '';
                  },
                ),
                CustomTextField(
                  title: 'Password',
                  texFieldController: password,
                  hint: 'Enter password',
                  validator: (String) {
                    return '';
                  },
                ),
                CustomTextField(
                  title: 'Phone number',
                  texFieldController: phoneNumber,
                  hint: 'Enter phone number',
                  validator: (String) {
                    return '';
                  },
                ),
                CustomTextField(
                  title: 'Date of birth',
                  texFieldController: dateOfBirth,
                  hint: 'Enter date of birth',
                  validator: (String) {
                    return '';
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: DSColors.darkPurple,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TransactionsTile(
                        isSelected: selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        text: 'Employee',
                      ),
                      TransactionsTile(
                        isSelected: selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        text: 'Advisor',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: LoadingButton(
            buttonText: 'Sign up user',
            goNextScreen: () async {
              if (checkIfFieldsAreEmptyTrowError()) {
              } else {
                QueriesFunctions().createUser(
                  firstName: firstName.text,
                  lastName: lastName.text,
                  email: email.text,
                  password: password.text,
                  phone: phoneNumber.text,
                  dateOfBirth: dateOfBirth.text,
                  isAdvisor: selectedIndex == 0 ? false : true,
                );
                Navigator.pop(context);
              }
              _controller.reset();
            },
            controller: _controller,
          ),
        ),
      ),
    );
  }

  bool checkIfFieldsAreEmptyTrowError() {
    if (firstName.text.trim() == '' ||
        lastName.text.trim() == '' ||
        email.text.trim() == '' ||
        password.text.trim() == '' ||
        phoneNumber.text.trim() == '' ||
        dateOfBirth.text.trim() == '') {
      ShowSnackBar(context: context, doesItAppearAtTheBottom: true)
          .showErrorSnackBar(
        message: "One or more fields are empty.",
        color: DSColors.accentsErrorRed,
      );
      return true;
    } else {
      return false;
    }
  }

  int getEmployeeIdByName(
      {required String employeeName, required List<AppUser> employees}) {
    int employeeId = 0;
    for (int i = 0; i < employees.length; i++) {
      if (employeeName ==
          '${employees[i].firstName} ${employees[i].lastName}') {
        employeeId = employees[i].id;
      }
    }
    return employeeId;
  }
}

class TransactionsTile extends StatelessWidget {
  final bool isSelected;
  final void Function() onTap;
  final String text;
  const TransactionsTile(
      {Key? key,
      required this.isSelected,
      required this.onTap,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? DSColors.white : DSColors.transparent,
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: isSelected
                  ? DSStandardText(
                      text: text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DSColors.darkPurple,
                    )
                  : DSStandardText(
                      text: text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: DSColors.white,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
