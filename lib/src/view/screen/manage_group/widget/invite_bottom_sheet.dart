
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

  @override
  void initState() {
    super.initState();
    controller.groupUser();
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
                          controller.toggleEmailSelection(
                              user.email ?? '', val);
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
