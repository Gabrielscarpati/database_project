import 'package:flutter/material.dart';

import '../colors.dart';
import 'ds_standard_text.dart';

class DSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButton;
  const DSAppBar({Key? key, required this.title, required this.isBackButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: DSColors.darkPurple,
      leading: isBackButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: DSColors.white),
            )
          : null,
      title: DSStandardText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: DSColors.white,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}
