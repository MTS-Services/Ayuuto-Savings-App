import 'package:flutter/material.dart';

class CustomInfoBox extends StatelessWidget {
  final String label;
  final String value;
  final double heightFactor;
  final double widthFactor;
  final Color color;
  final BorderRadius borderRadius;
  final List<BoxShadow> boxShadow;

  const CustomInfoBox({
    super.key,
    required this.label,
    required this.value,
    this.heightFactor = 0.01,
    this.widthFactor = 0.25,
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.boxShadow = const [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 2,
        spreadRadius: 2,
        offset: Offset(2, 2),
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double containerHeight = screenHeight * heightFactor;
    double containerWidth = screenWidth * widthFactor;

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(

                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
