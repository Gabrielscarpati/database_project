import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../colors.dart';
import '../components/DSTextFIeld.dart';
import '../components/DS_app_bar.dart';
import '../components/date_picker.dart';
import '../components/ds_standard_text.dart';
import '../components/loading_button.dart';
import '../data/authetication.dart';
import 'list_signup_city/choose_city_screen.dart';

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  DatePicker(
                    onDateTimeChanged: (value) {},
                    selectedDate: selectedDate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: IgnorePointer(
                      ignoring:
                          true, // Set to true to make the widget non-clickable
                      child: LoadingButton(
                        buttonText: 'Choose Employees',
                        goNextScreen: () async {
                          /*QueriesFunctions().insertIntoProject(
                          projectDueDate: '2021-10-10',
                          projectTitle: _projectTitleController.text,
                          advisorId: widget.advisorId,
                        );*/
                        },
                        controller: RoundedLoadingButtonController(),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChooseCityScreen()));
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
              /*QueriesFunctions().insertIntoProject(
                projectDueDate: '2021-10-10',
                projectTitle: _projectTitleController.text,
                advisorId: widget.advisorId,
              );*/
              QueriesFunctions().getAvailableEmployees();
              _controller.reset();
            },
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
/*class QueriesFunctions { insertIntoProject
*/
