import 'package:flutter/material.dart';

import '../data/authetication.dart';
import '../entity/project.dart';

class ProjectProvider with ChangeNotifier {
  static final ProjectProvider provider = ProjectProvider._internal();

  factory ProjectProvider() {
    return provider;
  }

  ProjectProvider._internal();

  bool isChecked = false;

  void updateIsCheck() {
    isChecked = !isChecked;
  }

  int advisorId = 0;

  void ifAdvisorSetAdvisorId(int id) {
    advisorId = id;
  }

  QueriesFunctions queriesFunctions = QueriesFunctions();
  List<Project> projects = [];
  Future<List<Project>> fetchProjectsByAdvisor() async {
    projects = [];
    projects = await queriesFunctions.getProjectsByAdvisor(advisorId);
    return projects;
  }

  DateTime selectedProjectCreationDateDateTime = DateTime.now();
  void setSelectedProjectCreationDate(DateTime date) {
    selectedProjectCreationDateDateTime = date;
    notifyListeners();
  }
}
