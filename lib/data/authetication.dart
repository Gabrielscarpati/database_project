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
    try {
      dynamic response = await supabase
          .rpc('get_projects_by_advisor', params: {'advisorid_param': id});

      if (response == null || response.isEmpty) {
        throw Exception(
            'There are no projects assigned by you. Click on the plus button to create a new one.');
      }

      List<Project> projects = [];
      for (var i = 0; i < response.length; i++) {
        final project = Project.fromJson(response[i]);
        projects.add(project);
      }

      return projects;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getTasksByProjectIdForAdvisor(int id) async {
    try {
      dynamic response = await supabase
          .rpc('tasks_for_projects', params: {'projectid_param': id});

      if (response == null || response.isEmpty) {
        throw Exception(
            'There are no tasks for this project. Click on the plus button to create a new one.');
      }

      List<Task> tasks = [];
      for (var i = 0; i < response.length; i++) {
        final task = Task.fromJson(response[i]);
        tasks.add(task);
      }

      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getTasksByProjectIdForEmployee(int id) async {
    try {
      dynamic response = await supabase
          .rpc('tasks_for_employee', params: {'employeeid_param': id});

      if (response == null || response.isEmpty) {
        throw Exception(
            'There are no tasks for you yet! Please wait for your manager to assign you a task.');
      }

      List<Task> tasks = [];
      for (var i = 0; i < response.length; i++) {
        final project = Task.fromJson(response[i]);
        tasks.add(project);
      }

      return tasks;
    } catch (e) {
      rethrow;
    }
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

  Future<void> deleteTask(int projectId, int taskId) async {
    await supabase.rpc('delete_task',
        params: {'projectid_param': projectId, 'taskid_param': taskId});
  }

  Future<void> deleteProject(int projectId) async {
    await supabase
        .rpc('make_employee_available_on_project_delete_func', params: {
      'projectid_param': projectId,
    });
  }

  Future<void> toggleTaskCompleted(int taskId) async {
    await supabase
        .rpc('toggle_task_completed', params: {'taskid_param': taskId});
  }
}
