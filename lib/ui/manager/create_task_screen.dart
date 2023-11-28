import 'package:database_project/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../colors.dart';
import '../../components/DSTextFIeld.dart';
import '../../components/DS_app_bar.dart';
import '../../components/DsDropDown.dart';
import '../../components/date_picker.dart';
import '../../components/ds_future_builder.dart';
import '../../components/ds_standard_text.dart';
import '../../components/loading_button.dart';
import '../../components/snackBar.dart';
import '../../data/authetication.dart';
import '../../providers/TaskProvider.dart';

class CreateTaskScreen extends StatefulWidget {
  final int projectId;
  const CreateTaskScreen({Key? key, required this.projectId}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final RoundedLoadingButtonController _controller =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    List<String> employees = [];
    List<AppUser> employeeObjects = [];

    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: const DSAppBar(
          title: 'Create a new task',
          isBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                title: 'Task name',
                texFieldController: taskProvider.taskName,
                hint: 'Enter task name',
                validator: (String) {
                  return '';
                },
              ),
              CustomTextField(
                title: 'Task description',
                texFieldController: taskProvider.taskDescription,
                hint: 'Enter task description',
                validator: (String) {
                  return '';
                },
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 4,
                ),
                child: DSStandardText(
                    text: 'Enter Assignee Name',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: DSColors.darkPurple),
              ),
              DSFutureBuilder(
                future:
                    QueriesFunctions().getEmployeesToTasks(widget.projectId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AppUser>> snapshot) {
                  employeeObjects = snapshot.data!;
                  for (AppUser employee in employeeObjects) {
                    employees.add('${employee.firstName} ${employee.lastName}');
                  }

                  taskProvider.selectedEmployeeDropDown == ''
                      ? taskProvider.selectedEmployeeDropDown = employees[0]
                      : taskProvider.selectedEmployeeDropDown;
                  print(taskProvider.selectedEmployeeDropDown);
                  return SizedBox(
                    child: DSDropdown(
                      hintText: taskProvider.selectedEmployeeDropDown,
                      items: employees,
                      selectedValue: taskProvider.selectedEmployeeDropDown,
                      onChanged: (value) {
                        if (value != null) {
                          taskProvider.selectedEmployeeDropDown = value;
                        }
                      },
                      onSaved: (p0) {},
                    ),
                  );
                },
                messageWhenEmpty: '',
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: DSStandardText(
                        text: 'Select due date',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: DSColors.darkPurple),
                  ),
                  DatePickerDueDateCreateTask(
                    onDateTimeChanged: (value) {},
                    selectedDate: taskProvider.selectedTaskDueDateDateDateTime,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: LoadingButton(
            buttonText: 'Create Task',
            goNextScreen: () async {
              if (taskProvider.taskName.text.trim() == '' ||
                  taskProvider.taskDescription.text.trim() == '') {
                ShowSnackBar(context: context, doesItAppearAtTheBottom: true)
                    .showErrorSnackBar(
                  message: "One or more fields are empty.",
                  color: DSColors.accentsErrorRed,
                );
              } else {
                QueriesFunctions().createTask(
                  projectId: widget.projectId,
                  employeeId: getEmployeeIdByName(
                    employeeName: taskProvider.selectedEmployeeDropDown,
                    employees: employeeObjects,
                  ),
                  taskName: taskProvider.taskName.text.trim(),
                  taskDescription: taskProvider.taskDescription.text.trim(),
                  taskDueDate: DateFormat('yyyy-MM-dd')
                      .format(taskProvider.selectedTaskDueDateDateDateTime),
                );

                taskProvider.popToMyTasksRebuildScreen(context);
              }
              _controller.reset();
            },
            controller: _controller,
          ),
        ),
      ),
    );
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
