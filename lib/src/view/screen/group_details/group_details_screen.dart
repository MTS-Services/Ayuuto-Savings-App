import 'package:ayuuto_savings_app/src/model/get_group_model/get_group_model.dart';
import 'package:ayuuto_savings_app/src/view/screen/group_details/widget/custome_member_tile.dart';
import 'package:flutter/material.dart';
import '../Individual Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/group_details/widget/custom_container_widget.dart';

class GroupDetailsScreen extends StatefulWidget {
  final GetGroupModel group;
  const GroupDetailsScreen({super.key, required this.group});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  List<String> labels = ['Members', 'Current Round', 'Monthly Amount'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Group Details",
        actionIcon: Icons.notifications,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.group.groupName,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: labels.length,
                itemBuilder: (context, index) {
                  String label = labels[index];
                  String value = "";

                  if (label == 'Members') {
                    value = widget.group.totalMembers.toString();
                  } else if (label == 'Current Round') {
                    value = widget.group.roundInfo;
                  } else if (label == 'Monthly Amount') {
                    value = "\$${widget.group.contributionAmount}";
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
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Group Members",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.group.members.length,
                itemBuilder: (context, index) {
                  final member = widget.group.members[index];

                  return Card(
                    elevation: 1,
                    color: Colors.white,
                    child: CustomMemberTile(
                      memberName:  member['name'] ?? 'Unknown',
                      joinDate: member['joinDate'] ?? 'N/A',
                      position: '${index + 1}',
                      status: member['status'] ?? 'Pending',
                      statusColor: (member['status'] == 'Active')
                          ? Colors.green
                          : Colors.grey,
                      leadingAvatar: CircleAvatar(
                        backgroundImage: NetworkImage(
                          member['imageUrl'] ??
                              'https://via.placeholder.com/150',
                        ),
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
