import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserSection extends StatelessWidget {
  const UserSection({
    super.key,
    required this.userNames,
  });

  final List<String> userNames;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 3   ,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20, // Adjust size
                  backgroundColor: AppColor.filedColor, // Circle color
                  child: Icon(
                    Iconsax.user, // Iconsax profile icon
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  userNames[index],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          }),
    );
  }
}
