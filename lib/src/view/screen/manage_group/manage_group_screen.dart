
import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/group_details/group_details_screen.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/widget/group_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ManageGroupScreen extends StatefulWidget {
  const ManageGroupScreen({super.key});

  @override
  State<ManageGroupScreen> createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends State<ManageGroupScreen> {
  bool isActiveGroupSelected = true;

  final List<Map<String, String>> activeGroups = [
    {
      "groupName": "Group 1",
      "memberCount": "10 Members",
      "amount": "\$500 Monthly",
      "roundProgress": "2 of 6",
      "nextPayment": "May 20, 2023",
      "currentReceiver": "Michel T.",
    },
    {
      "groupName": "Group 2",
      "memberCount": "15 Members",
      "amount": "\$750 Monthly",
      "roundProgress": "1 of 5",
      "nextPayment": "June 1, 2023",
      "currentReceiver": "John D.",
    },
  ];

  final List<Map<String, String>> completedGroups = [
    {
      "groupName": "Group 1",
      "memberCount": "8 Members",
      "amount": "\$400 Monthly",
      "roundProgress": "6 of 6",
      "nextPayment": "Completed",
      "currentReceiver": "Alice P.",
    },
    {
      "groupName": "Group 2",
      "memberCount": "8 Members",
      "amount": "\$400 Monthly",
      "roundProgress": "6 of 6",
      "nextPayment": "Completed",
      "currentReceiver": "Alice P.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Manage Group",
        actionIcon: Icons.notifications,
        onTap:(){
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            // Row with Active Group and Complete buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isActiveGroupSelected = true;
                      });
                    },
                    child: Text("Active Group"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        isActiveGroupSelected = false;
                      });
                    },
                    child: Text("Complete"),
                  ),
                ),
              ],
            ),
            // Display groups based on selection
            Expanded(
              child: ListView.builder(
                itemCount: isActiveGroupSelected
                    ? activeGroups.length
                    : completedGroups.length,
                itemBuilder: (context, index) {
                  final groupData = isActiveGroupSelected
                      ? activeGroups[index]
                      : completedGroups[index];
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=>GroupDetailsScreen());
                    },
                    child: Card(
                      child: GroupCard(
                        groupName: groupData["groupName"]!,
                        memberCount: groupData["memberCount"]!,
                        amount: groupData["amount"]!,
                        roundProgress: groupData["roundProgress"]!,
                        nextPayment: groupData["nextPayment"]!,
                        currentReceiver: groupData["currentReceiver"]!,
                        onInvitePressed: () {
                          print("Invite button pressed!");
                        },
                        isCompleted: !isActiveGroupSelected, totalAmount: '\$500',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
