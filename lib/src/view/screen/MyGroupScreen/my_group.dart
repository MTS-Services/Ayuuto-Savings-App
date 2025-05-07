import 'package:ayuuto_savings_app/src/view/controller/groupservice/active_service_controller.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/my_group_two_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/payment_progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/Services/stripe_payment_service.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/action_button.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/my_group_top_card.dart';
import '../manage_group/manage_group_screen.dart';

class MyGroupScreen extends StatefulWidget {
  const MyGroupScreen({super.key});

  @override
  State<MyGroupScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  final RxBool isUserAdmin = false.obs;

  final ActiveServiceController _activeController =
      Get.put(ActiveServiceController());

  @override
  void initState() {
    super.initState();
    _activeController.fetchGroups();
    _loadUserRole();
  }

  void _loadUserRole() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        isUserAdmin.value = doc.exists && doc['role'] == 'admin';
      } catch (e) {
        print("Error fetching user role: $e");
        isUserAdmin.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: CustomAppBar(title: 'my_groups'.tr),
      body: Obx(
        () {
          if (_activeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final groups = _activeController.activeGroups;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: groups.length,
                    itemBuilder: (context, index) {
                      final group = groups[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyGroupTopCard(
                            groupName: group.groupName,
                            roundInfo:
                                'Round ${group.roundInfo} \$ ${group.contributionAmount} monthly',
                            status: group.status,
                            backgroundColor: AppColor.themeColor,
                            statusColor: AppColor.activeButton,
                          ),
                          Row(
                            children: [
                              MyGroupTwoScreen(
                                backgroundColor: AppColor.themeColor,
                                title: 'your_turn'.tr,
                                day: '5th',
                                monthYear: 'Sep 2025',
                                containerColor: Colors.grey.shade200,
                              ),
                              MyGroupTwoScreen(
                                backgroundColor: AppColor.themeColor,
                                title: 'next_payment'.tr,
                                day: '15th',
                                monthYear: 'oct 2025',
                              ),
                            ],
                          ),
                          PaymentProgressCard(
                            progressText: 'Payment Progress',
                            completedText: '1 of 5 completed',
                          ),
                          Row(
                            children: [
                              ActionButton(
                                title: 'pay_now'.tr,
                                onTap: () async {
                                  // Ensure Stripe Payment Initialization with the required details
                                  await StripePaymentService
                                      .paymentSheetInitialization(
                                          context,
                                          group.contributionAmount
                                              .round()
                                              .toString(),
                                          'USD');
                                },
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.zero,
                              ),
                              ActionButton(
                                title: 'details'.tr,
                                onTap: () {
                                  Get.to(() => ManageGroupScreen());
                                },
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.circular(10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
