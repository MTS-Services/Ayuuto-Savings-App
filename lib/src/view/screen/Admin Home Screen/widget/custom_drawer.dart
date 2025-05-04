import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/AllUserScreen/language%20controller/language_controller.dart';
import 'package:ayuuto_savings_app/src/view/screen/AllUserScreen/all_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final LanguageController languageController = Get.put(LanguageController());

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
                'app_name'.tr,
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
            title: Text('groups'.tr),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Iconsax.people),
            title: Text('all_users'.tr),
            onTap: () {
              Get.to(() => AllUserScreen());
            },
          ),
         
        ],
      ),
    );
  }
}
