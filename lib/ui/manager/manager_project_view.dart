import 'package:database_project/components/ds_floating_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../components/DS_app_bar.dart';
import '../../components/ds_future_builder.dart';
import '../../components/ds_task_display_title.dart';
import '../../data/authetication.dart';
import '../../entity/task.dart';
import '../../providers/TaskProvider.dart';
import 'create_task_screen.dart';

class ManagerProjectView extends StatefulWidget {
  final int projectId;
  const ManagerProjectView({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<ManagerProjectView> createState() => _ManagerProjectViewState();
}

class _ManagerProjectViewState extends State<ManagerProjectView> {
  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        floatingActionButton: DsFloatingActionButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CreateTaskScreen(projectId: widget.projectId),
              ),
            );
          },
        ),
        appBar: const DSAppBar(
          title: 'Created tasks',
          isBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DSFutureBuilder(
            future: QueriesFunctions()
                .getTasksByProjectIdForAdvisor(widget.projectId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              List<Task> tasks = snapshot.data!;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.3,
                      children: [
                        SlidableAction(
                          flex: 5,
                          borderRadius: BorderRadius.circular(10.0),
                          onPressed: (context) async {
                            await QueriesFunctions()
                                .deleteTask(widget.projectId, tasks[index].id);
                            setState(() {
                              tasks.removeAt(index);
                            });
                          },
                          backgroundColor: const Color(0xFFE74C3C),
                          foregroundColor: DSColors.white,
                          icon: CupertinoIcons.delete,
                          label: 'Delete',
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
