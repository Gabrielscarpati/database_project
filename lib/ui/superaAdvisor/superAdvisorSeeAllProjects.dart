import 'package:database_project/components/ds_future_builder.dart';
import 'package:database_project/ui/superaAdvisor/createUser.dart';
import 'package:database_project/ui/superaAdvisor/superAdvisorSeeAllTasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../colors.dart';
import '../../components/DS_app_bar.dart';
import '../../components/ds_project_display_title.dart';
import '../../data/authetication.dart';
import '../../entity/project.dart';

class SuperAdvisorSeeAllProjects extends StatefulWidget {
  final int advisorId;
  const SuperAdvisorSeeAllProjects({Key? key, required this.advisorId})
      : super(key: key);

  @override
  State<SuperAdvisorSeeAllProjects> createState() =>
      _SuperAdvisorSeeAllProjectsState();
}

class _SuperAdvisorSeeAllProjectsState
    extends State<SuperAdvisorSeeAllProjects> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: DSAppBar(
          title: 'My Projects',
          isBackButton: false,
          action: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateUser()),
              );
            },
            icon: const Icon(
              CupertinoIcons.add,
              color: DSColors.white,
              size: 30,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DSFutureBuilder(
            future: QueriesFunctions().getAllProjects(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
              List<Project> projects = snapshot.data!;
              return ListView.builder(
                itemCount: projects.length,
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
                                .deleteProject(projects[index].id);
                            setState(() {
                              projects.removeAt(index);
                            });
                          },
                          backgroundColor: const Color(0xFFE74C3C),
                          foregroundColor: DSColors.white,
                          icon: CupertinoIcons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: DSProjectDisplayTitle(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuperAdvisorSeeAllTasks(
                              projectId: projects[index].id,
                            ),
                          ),
                        );
                      },
                      projectTitle: projects[index].title,
                      dueDate: projects[index].dateDue,
                      projectId: projects[index].id,
                      projectCompleted: projects[index].projectCompleted,
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
