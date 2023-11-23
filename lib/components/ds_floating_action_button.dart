import 'package:database_project/colors.dart';
import 'package:flutter/material.dart';

class DsFloatingActionButton extends StatelessWidget {
  Function()? onTap;
  DsFloatingActionButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: DSColors.darkPurple,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: DSColors.white,
        size: 32,
      ), // Use a circular shape
    );
  }
}

//nameproject and due date
