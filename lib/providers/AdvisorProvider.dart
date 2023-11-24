import 'package:flutter/material.dart';

import '../data/authetication.dart';
import '../entity/project.dart';

class AdvisorProvider with ChangeNotifier {
  static final AdvisorProvider provider = AdvisorProvider._internal();

  factory AdvisorProvider() {
    return provider;
  }

  AdvisorProvider._internal();

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
}
