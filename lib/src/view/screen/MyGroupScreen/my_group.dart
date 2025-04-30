import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/model/group_model.dart';
import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/action_button.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/available_group_card.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/my_group_top_card.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/my_group_two_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/MyGroupScreen/widgets/payment_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manage_group/manage_group_screen.dart';

class MyGroupScreen extends StatefulWidget {
  const MyGroupScreen({super.key});

  @override
  State<MyGroupScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  List<GroupModel> myGroups = [
    GroupModel(
      groupName: "Savings Circle",
      roundInfo: "Round 3 of 10 \$500 monthly",
      status: "Active",
      yourTurnDay: "7th",
      yourTurnMonthYear: "Sep 2023",
      nextPaymentDay: "Oct 15",
      nextPaymentMonthYear: "6 days left",
      progressText: "Payment Progress",
      completedText: "2 of 10 completed",
    ),
    GroupModel(
      groupName: "Holiday Trip Fund",
      roundInfo: "Round 2 of 5 \$300 monthly",
      status: "Active",
      yourTurnDay: "15th",
      yourTurnMonthYear: "Oct 2023",
      nextPaymentDay: "Nov 10",
      nextPaymentMonthYear: "20 days left",
      progressText: "Payment Progress",
      completedText: "1 of 5 completed",
    ),
  ];

  List<GroupModel> availableGroups = [
    GroupModel(
      groupName: "Business Fund",
      roundInfo: "\$500 monthly 2 lots available",
      status: "",
      yourTurnDay: "",
      yourTurnMonthYear: "",
      nextPaymentDay: "",
      nextPaymentMonthYear: "",
      progressText: "",
      completedText: "",
    ),
    GroupModel(
      groupName: "Home Renovation",
      roundInfo: "\$300 monthly 5 lots available",
      status: "",
      yourTurnDay: "",
      yourTurnMonthYear: "",
      nextPaymentDay: "",
      nextPaymentMonthYear: "",
      progressText: "",
      completedText: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: CustomAppBar(title: "My Groups"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myGroups.length,
                itemBuilder: (context, index) {
                  final group = myGroups[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyGroupTopCard(
                        groupName: group.groupName,
                        roundInfo: group.roundInfo,
                        status: group.status,
                        backgroundColor: AppColor.themeColor,
                        statusColor: AppColor.activeButton,

                      ),
                      Row(
                        children: [
                          MyGroupTwoScreen(
                            backgroundColor: AppColor.themeColor,
                            title: "Your Turn",
                            day: group.yourTurnDay,
                            monthYear: group.yourTurnMonthYear,
                            containerColor: Colors.grey.shade200,
                          ),
                          MyGroupTwoScreen(
                            backgroundColor: AppColor.themeColor,
                            title: "Next Payment",
                            day: group.nextPaymentDay,
                            monthYear: group.nextPaymentMonthYear,
                          ),
                        ],
                      ),
                      PaymentProgressCard(
                        progressText: group.progressText,
                        completedText: group.completedText,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ActionButton(
                              title: "Pay Now",
                              onTap: () {},
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.zero,
                            ),
                          ),
                          Expanded(
                            child: ActionButton(
                              title: "Details",
                              onTap: () {
                                Get.to(()=>ManageGroupScreen());
                              },
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Group",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () {
                      // View All Tap Logic Here
                    },
                    child: Text(
                      "View All",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableGroups.length,
                itemBuilder: (context, index) {
                  final available = availableGroups[index];
                  return AvailableGroupCard(
                      groupName: available.groupName,
                      roundInfo: available.roundInfo);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
