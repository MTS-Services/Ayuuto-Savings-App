import 'package:ayuuto_savings_app/src/view/screen/group_details/widget/custome_member_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Individual Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/group_details/widget/custom_container_widget.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  List<String> labels = ['Members', 'Current Round', 'Monthly Amount'];

  Map<String, dynamic> groupDetails = {
    'member': 10,
    'currentRound': '5/10',
    'monthlyAmount': 500,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Group Details",
        actionIcon: Icons.notifications,
        onTap: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Group Name",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: labels.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String label = labels[index];
                  String value = "";

                  if (label == 'Members') {
                    value = groupDetails['member'].toString();
                  } else if (label == 'Current Round') {
                    value = groupDetails['currentRound'].toString();
                  } else if (label == 'Monthly Amount') {
                    value = "\$${groupDetails['monthlyAmount'].toString()}";
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomInfoBox(
                      label: label,
                      value: value,
                      heightFactor: 0.10,
                      widthFactor: 0.26,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 2,
                          spreadRadius: 2,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Group Members",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1,
                    color: Colors.white,
                    child: CustomMemberTile(
                      memberName: "John Doe",
                      joinDate: "2024-01-01",
                      position: "1",
                      status: "Active",
                      statusColor: Colors.green,
                      leadingAvatar: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

