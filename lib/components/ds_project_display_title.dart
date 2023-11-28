import 'package:database_project/colors.dart';
import 'package:database_project/components/ds_standard_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DSProjectDisplayTitle extends StatelessWidget {
  final Function() onTap;
  final String projectTitle;
  final DateTime dueDate;
  final int projectId;
  final double projectCompleted;
  const DSProjectDisplayTitle(
      {Key? key,
      required this.onTap,
      required this.projectTitle,
      required this.dueDate,
      required this.projectId,
      required this.projectCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        child: Container(
          height: 64,
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            color: DSColors.darkPurple.withOpacity(1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            DSStandardText(
                              text: 'Title   $projectId',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: DSColors.white,
                            ),
                            const SizedBox(width: 8.0),
                            DSStandardText(
                              text: 'completed: $projectCompleted%',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: DSColors.white,
                            ),
                          ],
                        ),
                        DSStandardText(
                          text: projectTitle,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: DSColors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DSStandardText(
                          text: 'Due Date',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: DSColors.white,
                        ),
                        DSStandardText(
                          text: formatDateTime(dueDate),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: DSColors.white,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child:
                          Icon(Icons.arrow_forward_ios, color: DSColors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('MM/dd/yyyy');
    return formatter.format(dateTime);
  }
}
