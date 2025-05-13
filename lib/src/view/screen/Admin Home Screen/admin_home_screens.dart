import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/custom_card.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/custom_drawer.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/quick_action_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/recent_activites.dart';
import 'package:ayuuto_savings_app/src/view/screen/create_group/create_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart' show Iconsax;

import '../manage_group/manage_group_screen.dart';

class AdminHomeScreens extends StatelessWidget {
  const AdminHomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Drawer Icon Button
                    Builder(builder: (context) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColor.buttonColor,
                          child: Icon(
                            Iconsax.menu_1, // Hamburger menu icon
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                    //Notification Button
                    CircleAvatar(
                      radius: 20, // Adjust size
                      backgroundColor: AppColor.buttonColor, // Circle color
                      child: Icon(
                        Iconsax.notification, // Iconsax profile icon
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Grid Cards
                Column(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          icon: Iconsax.profile_2user,
                          text: 'total_groups'.tr,
                          num: '8',
                        ),
                        CustomCard(
                          icon: Iconsax.user,
                          text: 'total_members'.tr,
                          num: '42',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          icon: Iconsax.calendar,
                          text: 'upcoming_payments'.tr,
                          num: '12',
                        ),
                        CustomCard(
                          icon: Iconsax.clock,
                          text: 'completed_payments'.tr,
                          num: '3',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Quick Actions Tab
                Text(
                  'quick_actions'.tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuickActionContainer(
                        onTab: () {
                          Get.to(() => CreateGroupScreen());
                        },
                        text: 'create_group'.tr,
                        icon: Iconsax.add_square),
                    QuickActionContainer(
                        onTab: () {
                          Get.to(() => ManageGroupScreen());
                        },
                        text: 'view_groups'.tr,
                        icon: Iconsax.profile_2user),
                    QuickActionContainer(
                        onTab: () {},
                        text: 'manage_payments'.tr,
                        icon: Iconsax.dollar_circle),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'recent_activity'.tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Recent Activities
                RecentActivities(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
