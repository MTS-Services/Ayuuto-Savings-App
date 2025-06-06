import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.icon,
    required this.text,
    required this.num,
  });
  final IconData? icon;
  final String text;
  final String num;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.13,
        width: MediaQuery.sizeOf(context).width * 0.45,
        decoration: BoxDecoration(
          color: AppColor.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                ],
              ),
              Text(
                num.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
