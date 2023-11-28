import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../colors.dart';
import '../../components/DS_app_bar.dart';
import '../../components/ds_future_builder.dart';
import '../../components/ds_task_display_title.dart';
import '../../data/authetication.dart';
import '../../entity/task.dart';

class SuperAdvisorSeeAllTasks extends StatefulWidget {
  final int projectId;
  const SuperAdvisorSeeAllTasks({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<SuperAdvisorSeeAllTasks> createState() =>
      _SuperAdvisorSeeAllTasksState();
}

class _SuperAdvisorSeeAllTasksState extends State<SuperAdvisorSeeAllTasks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
