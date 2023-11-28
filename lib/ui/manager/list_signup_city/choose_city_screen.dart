import 'package:database_project/entity/user.dart';
import 'package:database_project/providers/EmployeeProvider.dart';
import 'package:database_project/ui/manager/list_signup_city/standard_list_builder_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../colors.dart';
import '../../../components/DSTextFIeld.dart';
import '../../../components/DS_app_bar.dart';
import '../../../components/ds_future_builder.dart';
import '../../../components/loading_button.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCityScreen> createState() => _ChooseCityScreenState();
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  Future<List<AppUser>>? listAvailableEmployees;
  @override
  void initState() {
    listAvailableEmployees = EmployeeProvider().fetchAvailableEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController employeeNameController = TextEditingController();
    EmployeeProvider employeeProvider =
        Provider.of<EmployeeProvider>(context, listen: true);

    RoundedLoadingButtonController _controller =
        RoundedLoadingButtonController();

    return Scaffold(
        appBar: const DSAppBar(
          title: 'Choose employees',
          isBackButton: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    texFieldController: employeeNameController,
                    hint: 'search',
                    validator: (String) {
                      return '';
                    },
                    title: 'Enter Project Name',
                    prefixIcon: Icons.search,
                    onChange: (String) {
                      //employeeProvider.onSearchEmployee(String);
                    },
                  ),
                ],
              ),
            ),
            const ListBuilderSelectedCities(),
            const SizedBox(
              height: 12,
            ),
            DSFutureBuilder(
              future: listAvailableEmployees,
              builder: (BuildContext context,
                  AsyncSnapshot<List<AppUser>> snapshot) {
                return ListBuilderCities(
                  employees: snapshot.data!,
                  padding: 12,
                );
              },
              messageWhenEmpty: '',
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadingButton(
                  buttonText: 'Done',
                  goNextScreen: () async {
                    Navigator.pop(context);

                    _controller.reset();
                  },
                  controller: _controller,
                ),

                /*DSButtonLargePrimary(
                  onPressed: () {
                    if (_Provider.selected_cities.isEmpty) {
                      mostrarCompleteInfo(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChooseServiceScreen()),
                      );
                    }
                  },
                  text: getLocation.locationBR
                      ? "CONTINUAR (2/6)"
                      : "CONTINUE (2/6)",
                )*/
              ],
            ),
          ),
        ));
  }

  Future mostrarCompleteInfo(context) => showDialog(
        context: context,
        builder: (context) => PopUpSelectOneCity(),
      );
}

class PopUpSelectOneCity extends StatelessWidget {
  const PopUpSelectOneCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoundedLoadingButtonController _otherController =
        RoundedLoadingButtonController();

    return AlertDialog(
      title: const Text(
        'Select at least one city!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: DSColors.darkPurple,
            fontWeight: FontWeight.bold,
            fontSize: 24),
      ),
      actions: [
        LoadingButton(
          buttonText: 'Ok',
          goNextScreen: () async {
            _otherController.reset();
          },
          controller: _otherController,
        ),
      ],
    );
  }
}
