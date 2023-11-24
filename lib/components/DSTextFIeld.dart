import 'package:database_project/components/ds_standard_text.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class CustomTextField extends StatefulWidget {
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController texFieldController;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hint;
  final String title;
  final void Function(String)? onChange;

  const CustomTextField({
    Key? key,
    required this.texFieldController,
    this.onTap,
    required this.hint,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
    required this.title,
    this.onChange,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4,
            ),
            child: DSStandardText(
                text: widget.title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: DSColors.darkPurple),
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.bottom,
            onTap: widget.onTap,
            style: const TextStyle(
              fontSize: 16,
              color: DSColors.primaryTextBlack,
            ),
            onChanged: widget.onChange,
            controller: widget.texFieldController,
            cursorColor: DSColors.darkPurple,
            maxLines: null,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              filled: true,
              fillColor: Colors.transparent,
              hintText: widget.hint,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: DSColors.primaryTextBlack,
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: DSColors.lightPurple,
                  width: 1,
                ),
              ),
              hintStyle: const TextStyle(
                fontSize: 16,
                color: DSColors.primaryTextBlack,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon!,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Icon(
                      widget.suffixIcon!,
                    )
                  : null,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
