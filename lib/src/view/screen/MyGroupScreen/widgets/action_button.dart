import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final Radius bottomLeft;
  final Radius bottomRight;

  const ActionButton({
    super.key,
    required this.title,
    this.backgroundColor =
        const Color(0xffffffff), // Default color (change if needed)
    this.onTap,
    required this.bottomLeft,
    required this.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:  BorderRadius.only(
              bottomLeft: bottomLeft,
              bottomRight: bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade200,
                blurRadius: 0.1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
