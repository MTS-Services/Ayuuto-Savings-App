import 'package:flutter/material.dart';

class MyGroupTwoScreen extends StatelessWidget {
  final String title;
  final String day;
  final String monthYear;
  final Color? backgroundColor;
  final Color? containerColor;

  const MyGroupTwoScreen({
    super.key,
    required this.title,
    required this.day,
    required this.monthYear,
    this.backgroundColor,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              color: Colors.grey.shade200,
              blurRadius: 0.1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    day,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: containerColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Text(
                          monthYear,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
