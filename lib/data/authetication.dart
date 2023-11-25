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

  Future<int> insertIntoProject(
      {required String projectDueDate,
      required String projectTitle,
      required int advisorId}) async {
    Map<String, dynamic> projectIdMap =
        await supabase.rpc('insertintoproject', params: {
      'projectdatedue_param': projectDueDate,
      'projecttitle_param': projectTitle,
      'advisorid_param': advisorId,
    });
    int projectId = projectIdMap['projectid_obj'];
    return projectId;
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

  Future<List<AppUser>> assignEmployeeToProject(
      {required List<AppUser> employees,
      required int projectIdParameter}) async {
    for (int i = 0; i < employees.length; i++) {
      await supabase.rpc('assign_employee_project', params: {
        'employeeid_param': employees[i].id,
        'projectid_param': projectIdParameter,
      });
    }
    return employees;
  }

  Future<List<AppUser>> getEmployeesToTasks(int projectId) async {
    dynamic response = await supabase.rpc('get_project_employees', params: {
      'projectid_param': projectId,
    });
    List<AppUser> employees = [];
    for (var employee in response) {
      employees.add(AppUser.fromJson(employee));
    }
    return employees;
  }

  Future<void> createTask({
    required int projectId,
    required int employeeId,
    required String taskName,
    required String taskDescription,
    required String taskDueDate,
  }) async {
    await supabase.rpc('create_task', params: {
      'projectid_param': projectId,
      'employeeid_param': employeeId,
      'taskname_param': taskName,
      'taskdescription_param': taskDescription,
      'taskdatedue_param': taskDueDate,
    });
    return;
  }
}
