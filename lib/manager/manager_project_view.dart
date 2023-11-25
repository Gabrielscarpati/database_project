import 'package:database_project/components/ds_floating_action_button.dart';
import 'package:flutter/material.dart';

import '../components/DS_app_bar.dart';
import '../components/ds_future_builder.dart';
import '../components/ds_task_display_title.dart';
import '../data/authetication.dart';
import '../entity/task.dart';
import 'create_task_screen.dart';

class ManagerProjectView extends StatelessWidget {
  final int projectId;
  const ManagerProjectView({Key? key, required this.projectId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: DsFloatingActionButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTaskScreen(projectId: projectId),
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
            future: QueriesFunctions().getTasksByProjectIdForAdvisor(projectId),
            builder:
                (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
              List<Task> projects = snapshot.data!;
              return ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return DSTaskDisplayTile(
                    taskName: projects[index].description,
                    taskDescription: projects[index].description,
                    dueDate: projects[index].dateDue,
                    createdDate: projects[index].dateCreated,
                    assignedTo:
                        '${projects[index].firstname} ${projects[index].lastname}',
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
