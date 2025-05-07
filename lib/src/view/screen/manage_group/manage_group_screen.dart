import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:ayuuto_savings_app/src/view/screen/manage_group/widget/group_card.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/groupinvitecontroller/send_invite_code.dart';
import '../../controller/groupservice/active_service_controller.dart';
import '../../controller/groupservice/complete_service_controller.dart';
import '../Individual Group/widget/custom_appbar.dart';
import '../group_details/group_details_screen.dart';

class ManageGroupScreen extends StatefulWidget {
  const ManageGroupScreen({super.key});

  @override
  State<ManageGroupScreen> createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends State<ManageGroupScreen> {
  final CompleteServiceController _completeController = Get.put(CompleteServiceController());
  final ActiveServiceController _activeController = Get.put(ActiveServiceController());
  final SendInviteCode _code = Get.put(SendInviteCode());

  final RxBool isActiveSelected = true.obs;
  final RxBool isUserAdmin = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _activeController.fetchGroups();
    _completeController.fetchGroups();
    _loadUserRole();
  }

  void _loadUserRole() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
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
      appBar: CustomAppBar(
        title: 'manage_group'.tr,
        actionIcon: Icons.notifications,
      ),
      body: Obx(() {
        if (_activeController.isLoading.value || _completeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final isActive = isActiveSelected.value;
        final groups = isActive ? _activeController.activeGroups : _completeController.completedGroups;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
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
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
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
                          totalAmount:
                          (group.contributionAmount * group.totalMembers).toString(),
                          onInvitePressed: () {},
                          isCompleted: group.status.toLowerCase() == 'completed',
                          groupId: group.groupId,
                          isAdmin: isUserAdmin.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Obx(() {
        return isUserAdmin.value
            ? const SizedBox.shrink()
            : SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () async {
              final isAccepted = await showGroupAcceptCodeDialog(
                context: context,
                codeControllerInstance: _code,
                authInstance: _auth,
              );

              if (isAccepted) {
                // show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const Center(child: CircularProgressIndicator()),
                );

                await _activeController.fetchGroups();
                await _completeController.fetchGroups();

                // hide loading
                Navigator.of(context).pop();

                showSnackBarMessage(context, "Group joined successfully!");
              } else {
                showSnackBarMessage(context, "Invalid code or failed to join group.");
              }
            },
            icon: const Icon(Icons.check),
            label: const Text(
              "Accept",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<bool> showGroupAcceptCodeDialog({
    required BuildContext context,
    required SendInviteCode codeControllerInstance,
    required FirebaseAuth authInstance,
  }) async {
    final TextEditingController codeTextController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Group Accept Code',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          content: TextField(
            controller: codeTextController,
            decoration: InputDecoration(
              labelText: 'Enter code',
              hintText: 'Ex: ABC123',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.vpn_key),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final code = codeTextController.text.trim();

                if (code.isEmpty) {
                  showSnackBarMessage(context, "Please enter a code");
                  return;
                }

                final isSuccess = await codeControllerInstance.sendInvitation(
                  context,
                  code,
                  authInstance.currentUser!.uid,
                );

                Navigator.of(context).pop(isSuccess);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
