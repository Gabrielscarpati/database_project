import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import 'ds_standard_text.dart';

class DatePicker<T> extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateTimeChanged;

  const DatePicker(
      {required this.onDateTimeChanged, super.key, required this.selectedDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = widget.selectedDate;
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2050),
        );

        if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
          });

          widget.onDateTimeChanged(selectedDate!);
        }
      },
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 44,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              border: Border.fromBorderSide(
                BorderSide(color: DSColors.primaryTextBlack),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: DSStandardText(
                        text: DateTimeConverter.convertDateTime(
                          selectedDate ?? DateTime.now(),
                        ),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: DSColors.primaryTextBlack,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(Icons.calendar_month_outlined,
                      color: DSColors.primaryTextBlack),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DateTimeConverter {
  static String convertDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('EEEE, dd MMM yyyy');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
}
