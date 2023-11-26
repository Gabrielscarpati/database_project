import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  static final TaskProvider provider = TaskProvider._internal();

  factory TaskProvider() {
    return provider;
  }

  TaskProvider._internal();

  DateTime selectedTaskDueDateDateDateTime = DateTime.now();
  void setSelectedTaskDueDate(DateTime date) {
    selectedTaskDueDateDateDateTime = date;
    notifyListeners();
  }

  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();

  String selectedEmployeeDropDown = '';

  void popToMyTasksRebuildScreen(BuildContext context) {
    Navigator.pop(context);
    Future.delayed(const Duration(milliseconds: 200), () {
      notifyListeners();
    });
  }
}
