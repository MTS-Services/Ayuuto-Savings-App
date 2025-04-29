import 'package:flutter/material.dart';

class PaymentProgressCard extends StatelessWidget {
  final String progressText;
  final String completedText;

  const PaymentProgressCard({
    super.key,
    required this.progressText,
    required this.completedText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  progressText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Text(
                  completedText,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    color: Colors.grey.shade200,
                    blurRadius: 0.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
