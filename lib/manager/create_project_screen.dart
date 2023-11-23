import 'package:flutter/material.dart';

import '../colors.dart';
import '../components/DSTextFIeld.dart';
import '../components/DS_app_bar.dart';
import '../components/date_picker.dart';
import '../components/ds_standard_text.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  DateTime selectedDate = DateTime.now();
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
                texFieldController: TextEditingController(),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
