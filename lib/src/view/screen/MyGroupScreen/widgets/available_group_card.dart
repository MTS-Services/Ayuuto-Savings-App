import 'package:flutter/material.dart';

class AvailableGroupCard extends StatelessWidget {
  final String groupName;
  final String roundInfo;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const AvailableGroupCard({
    super.key,
    required this.groupName,
    required this.roundInfo,
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              groupName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              roundInfo,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
