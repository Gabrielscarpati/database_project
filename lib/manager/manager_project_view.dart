import 'package:database_project/components/ds_floating_action_button.dart';
import 'package:flutter/material.dart';

import '../components/DS_app_bar.dart';
import '../components/ds_task_display_title.dart';
import 'create_task_screen.dart';

class ManagerProjectView extends StatelessWidget {
  const ManagerProjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: DsFloatingActionButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
            );
          },
        ),
        appBar: const DSAppBar(
          title: 'Created tasks',
          isBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              DSTaskDisplayTile(
                taskName: 'User Interface Design',
                taskDescription:
                    'Create wireframes and mockups for the user interface of a new web application.',
                dueDate: DateTime(2024, 12, 25),
                createdDate: DateTime(2024, 11, 15),
                assignedTo: 'Emily Johnson',
              ),
              DSTaskDisplayTile(
                taskName: 'System Maintenance',
                taskDescription:
                    'Perform routine system maintenance, including software updates and security patches.',
                dueDate: DateTime(2024, 12, 30),
                createdDate: DateTime(2024, 11, 20),
                assignedTo: 'Michael Smith',
              ),
              DSTaskDisplayTile(
                taskName: 'Client Meeting Preparation',
                taskDescription:
                    'Prepare presentation materials and agenda for an upcoming client meeting.',
                dueDate: DateTime(2024, 12, 5),
                createdDate: DateTime(2024, 11, 25),
                assignedTo: 'Sarah Davis',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
