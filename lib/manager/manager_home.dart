import 'package:database_project/components/ds_floating_action_button.dart';
import 'package:database_project/components/ds_project_display_title.dart';
import 'package:flutter/material.dart';

import '../components/DS_app_bar.dart';
import 'create_project_screen.dart';
import 'manager_project_view.dart';

class ManagerHome extends StatelessWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const DSAppBar(
          title: 'My Projects',
          isBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              DSProjectDisplayTitle(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagerProjectView(),
                    ),
                  );
                },
                projectTitle: 'Expense Tracker App',
                dueDate: DateTime(2024, 12, 15),
              ),
              DSProjectDisplayTitle(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagerProjectView(),
                    ),
                  );
                },
                projectTitle: 'E-commerce Mobile App',
                dueDate: DateTime(2025, 01, 30),
              ),
              DSProjectDisplayTitle(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagerProjectView(),
                    ),
                  );
                },
                projectTitle: 'Fitness Workout Planner',
                dueDate: DateTime(2025, 03, 10),
              ),
              DSProjectDisplayTitle(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagerProjectView(),
                    ),
                  );
                },
                projectTitle: 'Travel Journal App',
                dueDate: DateTime(2025, 04, 25),
              ),
            ],
          ),
        ),
        floatingActionButton: DsFloatingActionButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateProjectScreen()),
            );
          },
        ),
      ),
    );
  }
}
