import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/admin_home_screens.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment_Screen/payment_screen.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/manage_group_screen.dart';
import 'package:ayuuto_savings_app/src/view/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart' show Iconsax;

// Move testMembers here (GLOBAL)


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (value) =>
              controller.selectedIndex.value = value,
          backgroundColor: AppColor.buttonColor,
          // labelTextStyle: WidgetStateProperty.all(
          //   const TextStyle(
          //     fontSize: 12,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.white,
          //   ),
          // ),
          indicatorColor: Colors.white,
          destinations: [
            NavigationDestination(
              icon: Icon(
                Iconsax.home_copy,
                color: controller.selectedIndex.value == 0
                    ? Colors.black
                    : Colors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.profile_2user,
                color: controller.selectedIndex.value == 1
                    ? Colors.black
                    : Colors.white,
              ),
              label: 'Groups',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.wallet_3_copy,
                color: controller.selectedIndex.value == 2
                    ? Colors.black
                    : Colors.white,
              ),
              label: 'Payments',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.user,
                color: controller.selectedIndex.value == 3
                    ? Colors.black
                    : Colors.white,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 0.obs;

  final screens = [
    AdminHomeScreens(),
    ManageGroupScreen(),
    PaymentScreen(),
    ProfileScreen()
  ];
}
