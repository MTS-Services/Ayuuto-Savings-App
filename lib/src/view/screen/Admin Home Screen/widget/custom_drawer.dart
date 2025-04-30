import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/AllUserScreen/all_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart' show Iconsax;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(color: AppColor.buttonColor),
            child: Center(
              child: Text(
                'Ayuuto Savings App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Iconsax.profile_2user),
            title: Text('Groups'),
            onTap: () {
              // Handle Groups tap
            },
          ),
          ListTile(
            leading: Icon(Iconsax.people),
            title: Text('All Users'),
            onTap: () {
              // Handle Home tap
              Get.to(() => AllUserScreen());
            },
          ),
        ],
      ),
    );
  }
}
