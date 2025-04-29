import 'package:flutter/material.dart';

class AddCardNumber extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color borderColor;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final Widget? trailing;
  const AddCardNumber({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.onTap,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                   fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
          trailing ??Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
