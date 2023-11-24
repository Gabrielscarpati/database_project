import 'package:database_project/colors.dart';
import 'package:database_project/components/ds_standard_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DSTaskDisplayTile extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final DateTime dueDate;
  final DateTime createdDate;
  final String assignedTo;
  const DSTaskDisplayTile({
    Key? key,
    required this.taskName,
    required this.taskDescription,
    required this.dueDate,
    required this.createdDate,
    required this.assignedTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 4.0,
                ),
                child: DSStandardText(
                  text: taskName,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: DSColors.darkPurple,
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width - 24,
            decoration: BoxDecoration(
              color: DSColors.darkPurple.withOpacity(1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DSStandardText(
                            text: 'Assigned to',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DSColors.white,
                          ),
                          DSStandardText(
                            text: assignedTo,
                            textAlign: TextAlign.left,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: DSColors.white,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DSStandardText(
                            text: 'Task decription',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: DSColors.white,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6 - 24,
                            child: DSStandardText(
                              text: taskDescription,
                              textAlign: TextAlign.left,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: DSColors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DSStandardText(
                        text: 'Due Date',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: DSColors.white,
                      ),
                      DSStandardText(
                        text: formatDateTime(dueDate),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: DSColors.white,
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      const DSStandardText(
                        text: 'Created Date',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: DSColors.white,
                      ),
                      DSStandardText(
                        text: formatDateTime(createdDate),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: DSColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(dateTime);
  }
}
