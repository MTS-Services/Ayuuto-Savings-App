import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColor.filedColor,
                      child: Icon(
                        Iconsax.menu_1, // Hamburger menu icon
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    //Profile Button
                    CircleAvatar(
                      radius: 20, // Adjust size
                      backgroundColor: AppColor.filedColor, // Circle color
                      child: Icon(
                        Iconsax.user, // Iconsax profile icon
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),    
                //Grid Cards
                Column(
                  spacing: 15,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          widget: Column(),
                        ),
                        CustomCard(
                          widget: Column(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          widget: Column(),
                        ),
                        CustomCard(
                          widget: Column(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
