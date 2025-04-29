import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionPressed;
  final VoidCallback? onTap;
  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionPressed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.buttonColor,
      foregroundColor: AppColor.themeColor,
      leading: onTap != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onTap,
            )
          : null,
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: false,
      actions: [
        if (actionIcon != null)
          IconButton(
            icon: Icon(
              actionIcon,
              color: Colors.white,
            ),
            onPressed: onActionPressed,
          ),
      ],
    );
  }
   
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
