import 'package:database_project/components/ds_floating_action_button.dart';
import 'package:database_project/components/ds_future_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../components/DS_app_bar.dart';
import '../../components/ds_project_display_title.dart';
import '../../data/authetication.dart';
import '../../entity/project.dart';
import '../../providers/AdvisorProvider.dart';
import 'create_project_screen.dart';
import 'manager_project_view.dart';

class ManagerHome extends StatefulWidget {
  final int advisorId;
  const ManagerHome({Key? key, required this.advisorId}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  @override
  Widget build(BuildContext context) {
    AdvisorProvider advisorProvider =
        Provider.of<AdvisorProvider>(context, listen: true);

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
                            builder: (context) => ManagerProjectView(
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
        floatingActionButton: DsFloatingActionButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateProjectScreen(
                        advisorId: widget.advisorId,
                      )),
            );
          },
        ),
      ),
    );
  }
}
