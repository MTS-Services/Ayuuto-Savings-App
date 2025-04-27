import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/custom_card.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/custom_drawer.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/user_section.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AdminHomeScreens extends StatelessWidget {
  const AdminHomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> userNames = [
      "James Maina",
      "Sarah Wambui",
      "Michael Ochieng",
      "Grace Atieno",
      "David Kamau",
      "Linda Akinyi",
      "Robert Mwangi",
      "Esther Njeri",
      "Paul Odhiambo",
      "Joyce Auma"
    ];
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
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
                  //Profile Button
                  CircleAvatar(
                    radius: 20, // Adjust size
                    backgroundColor: AppColor.buttonColor, // Circle color
                    child: Icon(
                      Iconsax.user, // Iconsax profile icon
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //Grid Cards
              Wrap(
                spacing: 10,
                runSpacing: 15,
                children: [
                  CustomCard(
                    icon: Iconsax.people,
                    text: 'Total Group',
                  ),
                  CustomCard(
                    icon: Iconsax.user_tick,
                    text: 'Active Group',
                  ),
                  CustomCard(
                    icon: Iconsax.user_add,
                    text: 'Invite Member',
                  ),
                  CustomCard(
                    icon: Iconsax.profile_2user,
                    text: 'All Users',
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              //Search Box
              TextFormField(
                decoration: InputDecoration(hintText: "Search.."),
              ),
              SizedBox(
                height: 15,
              ),
              UserSection(userNames: userNames),
            ],
          ),
        ),
      ),
    );
  }
}
