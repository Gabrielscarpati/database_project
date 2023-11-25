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
        message: ""
            "You can only choose at most 4 employees",
        color: DSColors.accentsErrorRed,
      );
    }
  }

  Future<List<AppUser>> fetchAvailableEmployees() async {
    allAvailableEmployees = [];
    List<AppUser> allAvailableEmployeesLocal =
        await queriesFunctions.getAvailableEmployees();

    bool flagAllAvailableEmployees = true;
    bool flagAvailableEmployeesScreen = true;

    for (AppUser employee in allAvailableEmployeesLocal) {
      for (AppUser employeeInner in allAvailableEmployees) {
        if (employeeInner.id == employee.id) {
          flagAvailableEmployeesScreen = false;
        }
      }
      for (AppUser employeeInner in availableEmployeesScreen) {
        if (employeeInner.id == employee.id) {
          flagAllAvailableEmployees = false;
        }
      }
      if (flagAvailableEmployeesScreen == false ||
          flagAllAvailableEmployees == false) {
      } else {
        allAvailableEmployees.add(employee);
      }
    }
    return allAvailableEmployees;
  }
}
