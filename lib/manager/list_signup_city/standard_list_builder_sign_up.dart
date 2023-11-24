import 'package:database_project/components/ds_standard_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../entity/user.dart';
import '../../providers/EmployeeProvider.dart';

class ListBuilderCities extends StatelessWidget {
  final double padding;
  final List<AppUser> employees;
  const ListBuilderCities(
      {Key? key, required this.employees, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmployeeProvider employeeProvider =
        Provider.of<EmployeeProvider>(context, listen: true);

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          right: padding,
          left: padding,
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: employees.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ChooseEmployeeTile(
                employeeName:
                    '${employees[index].firstName} ${employees[index].lastName}',
                onTap: () {
                  employeeProvider.addListEmployeeScreen(
                      employees[index], context);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListBuilderSelectedCities extends StatelessWidget {
  const ListBuilderSelectedCities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EmployeeProvider provider = context.watch<EmployeeProvider>();
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 16,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.availableEmployeesScreen.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: InkWell(
                child: Container(
                  width: 176,
                  height: 30,
                  decoration: BoxDecoration(
                    color: DSColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset:
                            const Offset(0, -4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DSStandardText(
                          text:
                              "${provider.availableEmployeesScreen[index].firstName} ${provider.availableEmployeesScreen[index].lastName}",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: DSColors.darkPurple,
                        ),
                        const Icon(Icons.close)
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  provider.removeEmployeeList(
                      provider.availableEmployeesScreen[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChooseEmployeeTile extends StatelessWidget {
  final String employeeName;
  final Function() onTap;
  const ChooseEmployeeTile(
      {Key? key, required this.employeeName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: DSColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, -4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.work,
                color: DSColors.darkPurple,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                employeeName,
                style: TextStyle(
                  color: DSColors.darkPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
