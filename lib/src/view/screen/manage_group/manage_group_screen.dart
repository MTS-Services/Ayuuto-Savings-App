import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/widget/group_card.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
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
        title: 'manage_group'.tr,
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
                          backgroundColor: isActive ? Colors.white : Colors.white,
                          foregroundColor: isActive ? Colors.black : Colors.black,
                        ),
                        onPressed: () {
                          isActiveSelected.value = true;
                        },
                        child: Text('active_groups'.tr),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !isActive ? Colors.white : Colors.white,
                          foregroundColor: !isActive ? Colors.black : Colors.black,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        onPressed: () {
                          isActiveSelected.value = false;
                        },
                        child: Text('complete'.tr),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: groups.isEmpty
                      ? Center(
                    child: Text(
                      'no_groups_found'.tr,
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
                            nextPayment: group.status.toLowerCase() == "active"
                                ? group.nextCycleDate?.toString() ?? "No date"
                                : 'group_status_pending'.tr,
                            currentReceiver: group.lastWinnerName,
                            totalAmount: (group.contributionAmount *
                                group.totalMembers)
                                .toString(),
                            onInvitePressed: () {},
                            isCompleted: group.status.toLowerCase() == 'completed',
                            groupId: group.groupId,
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
      floatingActionButton: SizedBox(
        height: 50,
        child: ElevatedButton.icon(
          onPressed: () {
            showGroupAcceptCodeDialog(
              context: context,
              onSubmit: (code) {
                final allGroups = [
                  ..._activeController.activeGroups,
                  ..._completeController.completedGroups,
                ];

                final matchedGroup = allGroups.firstWhereOrNull(
                      (group) => group.groupId.toString() == code,
                );

                if (matchedGroup != null) {
                  final isActive = matchedGroup.status.toLowerCase() == 'active';
                  isActiveSelected.value = isActive;

                  if (isActive) {
                    _activeController.activeGroups.assignAll([matchedGroup]);
                  } else {
                    _completeController.completedGroups.assignAll([matchedGroup]);
                  }

                  showSnackBarMessage(context, "Group found!");
                } else {
                  showSnackBarMessage(context, "Invalid code!");
                }
              },
            );
          },
          icon: Icon(Icons.check),
          label: Text(
            "Accept",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  void showGroupAcceptCodeDialog({
    required BuildContext context,
    required void Function(String code) onSubmit,
  }) {
    final TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Group Accept Code',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: TextField(
            controller: codeController,
            decoration: InputDecoration(
              labelText: 'Enter code',
              hintText: 'Ex: ABC123',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: Icon(Icons.vpn_key),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final code = codeController.text.trim();
                if (code.isEmpty) {
                  showSnackBarMessage(context, "Please enter a code");
                } else {
                  Navigator.of(context).pop();
                  onSubmit(code);
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
