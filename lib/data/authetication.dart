import 'package:database_project/entity/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../entity/project.dart';
import '../entity/user.dart';

final supabase = Supabase.instance.client;

class QueriesFunctions {
  Future<bool> isAdvisor(int id) async {
    dynamic response =
        await supabase.rpc('check_advisor', params: {'id_param': id});
    return response;
  }

  Future<List<Project>> getProjectsByAdvisor(int id) async {
    dynamic response = await supabase
        .rpc('get_projects_by_advisor', params: {'advisorid_param': id});
    List<Project> projects = [];
    for (var i = 0; i < response.length; i++) {
      final project = Project.fromJson(response[i]);
      projects.add(project);
    }

    return projects;
  }

  Future<List<Task>> getTasksByProjectIdForAdvisor(int id) async {
    dynamic response = await supabase
        .rpc('tasks_for_projects', params: {'projectid_param': id});
    List<Task> tasks = [];
    for (var i = 0; i < response.length; i++) {
      final project = Task.fromJson(response[i]);
      tasks.add(project);
    }
    return tasks;
  }

  Future<List<Task>> getTasksByProjectIdForEmployee(int id) async {
    dynamic response = await supabase
        .rpc('tasks_for_employee', params: {'employeeid_param': id});
    List<Task> tasks = [];
    for (var i = 0; i < response.length; i++) {
      final project = Task.fromJson(response[i]);
      tasks.add(project);
    }
    return tasks;
  }

  Future<void> insertIntoProject(
      {required String projectDueDate,
      required String projectTitle,
      required int advisorId}) async {
    dynamic response = await supabase.rpc('insertintoproject', params: {
      'projectdatedue_param': projectDueDate,
      'projecttitle_param': projectTitle,
      'advisorid_param': advisorId,
    });
  }

  Future<List<AppUser>> getAvailableEmployees() async {
    dynamic response = await supabase.rpc(
      'get_available_employees',
    );
    List<AppUser> employees = [];
    for (var i = 0; i < response.length; i++) {
      final user = AppUser.fromJson(response[i]);
      employees.add(user);
    }
    return employees;
  }
}
