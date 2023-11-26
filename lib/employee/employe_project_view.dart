import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../colors.dart';
import '../components/DS_app_bar.dart';
import '../components/ds_future_builder.dart';
import '../components/ds_task_display_title.dart';
import '../data/authetication.dart';
import '../entity/task.dart';

class EmployeeProjectView extends StatefulWidget {
  final int projectId;
  const EmployeeProjectView({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<EmployeeProjectView> createState() => _EmployeeProjectViewState();
}

class _EmployeeProjectViewState extends State<EmployeeProjectView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const DSAppBar(
          title: 'My Tasks',
          isBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DSFutureBuilder(
            future: QueriesFunctions()
                .getTasksByProjectIdForEmployee(widget.projectId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              List<Task> tasks = snapshot.data!;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.33,
                      children: [
                        SlidableAction(
                          flex: 5,
                          borderRadius: BorderRadius.circular(10.0),
                          padding: const EdgeInsets.all(0.0),
                          onPressed: (context) async {
                            await QueriesFunctions()
                                .toggleTaskCompleted(tasks[index].id);
                            setState(() {});
                          },
                          backgroundColor: tasks[index].completed
                              ? DSColors.greyScaleMediumGrey
                              : Colors.green,
                          foregroundColor: DSColors.white,
                          icon: Icons.update,
                          label: tasks[index].completed
                              ? 'uncompleted'
                              : 'completed',
                        ),
                      ],
                    ),
                    child: DSTaskDisplayTile(
                      taskName: tasks[index].description,
                      taskDescription: tasks[index].description,
                      dueDate: tasks[index].dateDue,
                      createdDate: tasks[index].dateCreated,
                      assignedTo:
                          '${tasks[index].firstname} ${tasks[index].lastname}',
                      isCompleted: tasks[index].completed,
                    ),
                  );
                },
              );
            },
            messageWhenEmpty: '',
          ),
        ),
      ),
    );
  }
}
