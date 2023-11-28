import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../colors.dart';
import '../../components/DSTextFIeld.dart';
import '../../components/DS_app_bar.dart';
import '../../components/date_picker.dart';
import '../../components/ds_standard_text.dart';
import '../../components/loading_button.dart';
import '../../components/snackBar.dart';
import '../../data/authetication.dart';
import '../../providers/AdvisorProvider.dart';
import '../../providers/EmployeeProvider.dart';
import '../../providers/ProjectProvider.dart';
import 'list_signup_city/choose_city_screen.dart';
import 'list_signup_city/standard_list_builder_sign_up.dart';

class CreateProjectScreen extends StatefulWidget {
  final int advisorId;
  const CreateProjectScreen({Key? key, required this.advisorId})
      : super(key: key);

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  DateTime selectedDate = DateTime.now();
  RoundedLoadingButtonController _controller = RoundedLoadingButtonController();
  TextEditingController _projectTitleController = TextEditingController();

  @override
  void initState() {
    EmployeeProvider().availableEmployeesScreen.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EmployeeProvider employeeProvider =
        Provider.of<EmployeeProvider>(context, listen: true);
    ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context, listen: true);
    AdvisorProvider advisorProvider =
        Provider.of<AdvisorProvider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const DSAppBar(
          title: 'Create New Project',
          isBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomTextField(
                texFieldController: _projectTitleController,
                hint: '',
                validator: (String) {
                  return '';
                },
                title: 'Enter Project Name',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DSStandardText(
                    text: 'Select Start Date',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: DSColors.darkPurple,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  DatePickerCreateProject(
                    onDateTimeChanged: (value) {},
                    selectedDate:
                        projectProvider.selectedProjectCreationDateDateTime,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (employeeProvider.availableEmployeesScreen.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DSStandardText(
                            text: 'Selected Employee',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: DSColors.darkPurple),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height:
                              employeeProvider.availableEmployeesScreen.length *
                                  80.toDouble(),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: employeeProvider
                                .availableEmployeesScreen.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: ChooseEmployeeTile(
                                  employeeName:
                                      "${employeeProvider.availableEmployeesScreen[index].firstName} ${employeeProvider.availableEmployeesScreen[index].lastName}",
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  InkWell(
                    child: IgnorePointer(
                      ignoring:
                          true, // Set to true to make the widget non-clickable
                      child: LoadingButton(
                        buttonText: 'Choose Employees',
                        goNextScreen: () async {},
                        controller: RoundedLoadingButtonController(),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChooseCityScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ), //ListBuilderCities
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: LoadingButton(
            buttonText: 'Create Project',
            goNextScreen: () async {
              if (_projectTitleController.text.trim().isEmpty ||
                  employeeProvider.availableEmployeesScreen.isEmpty) {
                ShowSnackBar(context: context, doesItAppearAtTheBottom: true)
                    .showErrorSnackBar(
                  message: "One or more fields are empty.",
                  color: DSColors.accentsErrorRed,
                );
              } else {
                int projectId = await QueriesFunctions().insertIntoProject(
                  projectDueDate: DateFormat('yyyy-MM-dd').format(
                      projectProvider.selectedProjectCreationDateDateTime),
                  projectTitle: _projectTitleController.text.trim(),
                  advisorId: widget.advisorId,
                );

                QueriesFunctions().assignEmployeeToProject(
                  employees: employeeProvider.availableEmployeesScreen,
                  projectIdParameter: projectId,
                );
                advisorProvider.popToMyProjectsAndRebuildWidget(context);
              }

              _controller.reset();
            },
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
