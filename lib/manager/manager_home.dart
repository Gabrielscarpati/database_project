import 'package:database_project/components/ds_floating_action_button.dart';
import 'package:database_project/components/ds_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/DS_app_bar.dart';
import '../components/ds_project_display_title.dart';
import '../entity/project.dart';
import '../providers/AdvisorProvider.dart';
import 'create_project_screen.dart';

class ManagerHome extends StatelessWidget {
  final int advisorId;
  const ManagerHome({Key? key, required this.advisorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AdvisorProvider advisorProvider =
        Provider.of<AdvisorProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: const DSAppBar(
          title: 'My Projects',
          isBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DSFutureBuilder(
            future: advisorProvider.fetchProjectsByAdvisor(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
              List<Project> projects = snapshot.data!;
              return ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return DSProjectDisplayTitle(
                    onTap: () {},
                    projectTitle: projects[index].title,
                    dueDate: projects[index].dateDue,
                    projectId: projects[index].id,
                  );
                },
              );
            },
            messageWhenEmpty: '',
          ),
        ),
        floatingActionButton: DsFloatingActionButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateProjectScreen(
                        advisorId: advisorId,
                      )),
            );
          },
        ),
      ),
    );
  }
}
