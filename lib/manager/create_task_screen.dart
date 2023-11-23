import 'package:flutter/material.dart';

import '../colors.dart';
import '../components/DSTextFIeld.dart';
import '../components/DS_app_bar.dart';
import '../components/date_picker.dart';
import '../components/ds_standard_text.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const DSAppBar(
          title: 'Create a new task',
          isBackButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomTextField(
                title: 'Task name',
                texFieldController: TextEditingController(),
                hint: 'Enter task name',
                validator: (String) {
                  return '';
                },
              ),
              CustomTextField(
                title: 'Task description',
                texFieldController: TextEditingController(),
                hint: 'Enter task description',
                validator: (String) {
                  return '';
                },
              ),
              CustomTextField(
                title: 'Assignee Name',
                texFieldController: TextEditingController(),
                hint: 'Enter Assignee Name',
                validator: (String) {
                  return '';
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 4,
                    ),
                    child: DSStandardText(
                        text: 'Select due date',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: DSColors.darkPurple),
                  ),
                  DatePicker(
                    onDateTimeChanged: (value) {},
                    selectedDate: selectedDate,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
