import 'package:ayuuto_savings_app/src/view/screen/manage_group/widget/group_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/groupservice/active_service_controller.dart';
import '../../controller/groupservice/complete_service_controller.dart';
import '../Individual Group/widget/custom_appbar.dart';
import '../group_details/group_details_screen.dart';

class ManageGroupScreen extends StatefulWidget {
  const ManageGroupScreen({super.key});

  @override
  _ManageGroupScreenState createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends State<ManageGroupScreen> {
  final CompleteServiceController _completeController =
      Get.put(CompleteServiceController());
  final ActiveServiceController _activeController =
      Get.put(ActiveServiceController());

  final RxBool isActiveSelected = true.obs;

  @override
  void initState() {
    super.initState();
    _activeController.fetchGroups();
    _completeController.fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Manage Group",
        actionIcon: Icons.notifications,
      ),
      body: Obx(() {
        if (_activeController.isLoading.value ||
            _completeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final isActive = isActiveSelected.value;
          final groups = isActive
              ? _activeController.activeGroups
              : _completeController.completedGroups;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isActive ? Colors.blue : Colors.white,
                          foregroundColor:
                              isActive ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          isActiveSelected.value = true;
                        },
                        child: const Text("Active Group"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              !isActive ? Colors.blue : Colors.white,
                          foregroundColor:
                              !isActive ? Colors.white : Colors.black,
                        ),
                        onPressed: () {
                          isActiveSelected.value = false;
                        },
                        child: const Text("Complete"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: groups.isEmpty
                      ? Center(
                          child: Text(
                            "No groups found",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      : ListView.builder(
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            final group = groups[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => GroupDetailsScreen(group: group));
                              },
                              child: Card(
                                child: GroupCard(
                                  groupName: group.groupName,
                                  memberCount: group.totalMembers.toString(),
                                  amount: group.contributionAmount.toString(),
                                  roundProgress: group.roundInfo,
                                  nextPayment:
                                      group.status.toLowerCase() == "active"
                                          ? group.nextCycleDate?.toString() ??
                                              "No date"
                                          : "Group status pending",
                                  currentReceiver: group.lastWinnerName,
                                  totalAmount: (group.contributionAmount *
                                          group.totalMembers)
                                      .toString(),
                                  onInvitePressed: () {},
                                  isCompleted:
                                      group.status.toLowerCase() == 'completed',
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
      }),
    );
  }
}
