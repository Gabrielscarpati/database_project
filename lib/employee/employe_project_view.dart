import 'package:flutter/material.dart';

import '../components/DS_app_bar.dart';
import '../components/ds_task_display_title.dart';

class EmployeeProjectView extends StatelessWidget {
  const EmployeeProjectView({Key? key}) : super(key: key);

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
          child: Column(
            children: [
              DSTaskDisplayTile(
                taskName: 'Develop Mobile App UI',
                taskDescription:
                    'Design and implement the user interface for the mobile app, focusing on user experience and visual appeal.',
                dueDate: DateTime(2024, 12, 12),
                createdDate: DateTime(2024, 10, 1),
              ),
              DSTaskDisplayTile(
                taskName: 'Backend API Integration',
                taskDescription:
                    'Integrate the backend APIs with the mobile app, ensuring data retrieval and updates are smooth and efficient.',
                dueDate: DateTime(2024, 12, 15),
                createdDate: DateTime(2024, 10, 5),
              ),
              DSTaskDisplayTile(
                taskName: 'User Testing and Feedback',
                taskDescription:
                    'Conduct user testing sessions and gather feedback to make iterative improvements to the mobile app.',
                dueDate: DateTime(2024, 12, 20),
                createdDate: DateTime(2024, 10, 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
