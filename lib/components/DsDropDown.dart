import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import 'ds_standard_text.dart';

class DSDropdown extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?) onChanged;
  final void Function(String?) onSaved;
  final List<IconData>? icons;

  const DSDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.onSaved,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    print("Items: $items");
    print("Selected Value: $selectedValue");
    return SizedBox(
      height: 46,
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: DSColors.primaryTextBlack,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: DSColors.darkPurple,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: DSColors.darkPurple,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        hint: DSStandardText(
          text: 'Select $hintText',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: DSColors.darkPurple,
        ),
        value: selectedValue,
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Row(
                  children: [
                    icons == null
                        ? const SizedBox()
                        : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(icons![0]),
                              ),
                            ],
                          ),
                    DSStandardText(
                      text: item,
                      fontSize: 16,
                      color: DSColors.primaryTextBlack,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        onSaved: onSaved,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: const DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(1),
              topRight: Radius.circular(1),
              bottomRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(160, 84, 160, 0.24),
                offset: Offset(0, 4),
                blurRadius: 8,
                spreadRadius: 0,
              )
            ],
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
