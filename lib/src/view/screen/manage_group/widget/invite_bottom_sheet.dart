import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'invite_controller.dart';

class InviteBottomSheet extends StatelessWidget {
  const InviteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InviteController>(
      init: InviteController(),
      builder: (controller) {
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
                child: ListView.builder(
                  itemCount: controller.filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.filteredUsers[index];
                    final isSelected = controller.selectedEmails.contains(user['email']);

                    return ListTile(
                      leading: Checkbox(
                        value: isSelected,
                        onChanged: (val) =>
                            controller.toggleEmailSelection(user['email'], val),
                      ),
                      title: Text(
                        user['name'],
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        user['email'],
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: controller.selectedEmails.isEmpty
                    ? null
                    : () => controller.handleSendInvites(context),
                icon: const Icon(Icons.send),
                label: const Text("Send Invites"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
