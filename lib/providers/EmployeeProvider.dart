import 'package:database_project/entity/user.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../components/snackBar.dart';
import '../data/authetication.dart';

class EmployeeProvider with ChangeNotifier {
  static final EmployeeProvider provider = EmployeeProvider._internal();

  factory EmployeeProvider() {
    return provider;
  }

  EmployeeProvider._internal();

  bool isChecked = false;

  void updateIsCheck() {
    isChecked = !isChecked;
  }

  int employeeId = 0;

  void ifEmployeeSetEmployee(int id) {
    employeeId = id;
  }

  //QueriesFunctions  getAvailableEmployees

  QueriesFunctions queriesFunctions = QueriesFunctions();
  List<AppUser> allAvailableEmployees = [];
  List<AppUser> availableEmployeesScreen = [];

  void removeEmployeeList(AppUser newUser) {
    if (availableEmployeesScreen.isNotEmpty) {
      availableEmployeesScreen.remove(newUser);
      allAvailableEmployees.add(newUser);
      notifyListeners();
    }
  }

  void addListEmployeeScreen(AppUser newUser, BuildContext context) {
    bool isInList = false;
    if (availableEmployeesScreen.length < 4) {
      for (AppUser user in availableEmployeesScreen) {
        if (newUser.id == user.id) {
          isInList = true;
        }
      }
      if (isInList) {
      } else {
        availableEmployeesScreen.add(newUser);
        allAvailableEmployees.remove(newUser);
        notifyListeners();
      }
    } else {
      ShowSnackBar(context: context, doesItAppearAtTheBottom: true)
          .showErrorSnackBar(
        message: "You can only choose 3 employees",
        color: DSColors.accentsErrorRed,
      );
    }
  }

  Future<List<AppUser>> fetchAvailableEmployees() async {
    allAvailableEmployees = [];
    allAvailableEmployees = await queriesFunctions.getAvailableEmployees();
    return allAvailableEmployees;
  }

  /*void onSearchEmployee(String value) {
    availableEmployeesScreen = [];
    for (AppUser user in allAvailableEmployees) {
      if (("${user.firstName} ${user.firstName}")
          .toLowerCase()
          .contains(value.toLowerCase())) {
        availableEmployeesScreen.add(user);
      }
    }
    notifyListeners();
  }*/
}
