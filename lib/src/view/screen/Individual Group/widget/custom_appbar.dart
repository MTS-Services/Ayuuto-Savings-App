import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.groupName,
  });

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.buttonColor,
      title: Text(
        groupName,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}