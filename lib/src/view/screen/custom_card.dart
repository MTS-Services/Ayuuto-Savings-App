import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key, required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.12,
      width: MediaQuery.sizeOf(context).height * 0.2,
      decoration: BoxDecoration(
        color: AppColor.filedColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget,
    );
  }
}
