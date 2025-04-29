import 'package:flutter/material.dart';

class ArrowContainer extends StatelessWidget {
  const ArrowContainer({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Icon(icon, color: Colors.black, size: 20),
    );
  }
}
