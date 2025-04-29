import 'package:flutter/material.dart';

class MyGroupTopCard extends StatelessWidget {
  final String groupName;
  final String roundInfo;
  final String status;
  final Color backgroundColor;
  final Color? statusColor;

  const MyGroupTopCard({
    super.key,
    required this.groupName,
    required this.roundInfo,
    required this.status,
    required this.backgroundColor,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Text(
                      roundInfo,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: statusColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        status,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
