import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/individual_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> groupNames = [
      'Family Fund',
      'Travel Buddies',
      'Book Club',
      'Fitness Freaks',
      'Weekend Warriors',
      'Study Squad',
      'Startup Hustlers',
      'Photography Enthusiasts',
      'Movie Maniacs',
      'Food Lovers',
      'Adventure Seekers',
      'Savings Circle',
      'Investment Group',
      'Wedding Planners',
      'Tech Geeks',
      'Sports Fanatics',
      'Art Lovers',
      'Language Learners',
      'Music Vibes',
      'Dream Builders',
    ];

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(color: AppColor.buttonColor),
            child: Center(
              child: Text(
                'My Groups',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => IndividualGroup(
                            groupName: groupNames[index],
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          groupNames[index],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(Iconsax.arrow_right_3),
                        subtitle: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
