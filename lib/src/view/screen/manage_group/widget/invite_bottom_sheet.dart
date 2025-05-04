import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controller/groupinvitecontroller/send_invite_code.dart';
import '../../../controller/groupinvitecontroller/user_member_controller.dart';

class InviteBottomSheet extends StatefulWidget {
  final String groupId;

  const InviteBottomSheet({super.key, required this.groupId});

  @override
  State<InviteBottomSheet> createState() => _InviteBottomSheetState();
}

class _InviteBottomSheetState extends State<InviteBottomSheet> {
  final InviteController controller = Get.put(InviteController());
  final SendInviteCode inviteCodeController = Get.put(SendInviteCode());
  final TextEditingController inviteCodeTextController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    controller.groupUser();
  }

  void _showAcceptDialog(String userId) {
    inviteCodeTextController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Accept Invite',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please enter your code to accept the invite.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: inviteCodeTextController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: inviteCodeController.isInviting.value
                          ? null
                          : () async {
                        final code = inviteCodeTextController.text.trim();
                        if (code.isNotEmpty) {
                          await inviteCodeController.sendInvitation(
                            context,
                            code,
                            userId,
                          );
                          if (mounted) Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: inviteCodeController.isInviting.value
                          ? const SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Accept'),
                    );
                  }),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Invite Member", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),

            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 200,
              child: controller.isInProgress.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.filteredUsers.isEmpty
                  ? const Center(child: Text("No users found"))
                  : ListView.builder(
                itemCount: controller.filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = controller.filteredUsers[index];
                  final isSelected =
                  controller.selectedEmails.contains(user.email);

                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: isSelected,
                        onChanged: (bool? val) {
                          controller.toggleEmailSelection(user.email ?? '', val);
                        },
                      ),
                      title: Text(
                        user.name ?? 'No name',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                      ),
                      subtitle: Text(
                        user.email ?? 'No email',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: controller.selectedEmails.isEmpty
                  ? null
                  : () async {
                await controller.handleSendInvites(context, widget.groupId);

                  if (mounted) {
                    _showAcceptDialog(_auth.currentUser!.uid);
                  }

              },
              icon: const Icon(Icons.send),
              label: const Text("Send Invites"),
            ),

            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
