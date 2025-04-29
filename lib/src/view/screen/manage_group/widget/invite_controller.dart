import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  final List<Map<String, dynamic>> allUsers = [
    {'name': 'Sabbir Ahmed', 'email': 'sabbir@example.com'},
    {'name': 'Tamim Khan', 'email': 'tamim@example.com'},
    {'name': 'Ayesha Islam', 'email': 'ayesha@example.com'},
    {'name': 'Nayeem Uddin', 'email': 'nayeem@example.com'},
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  Set<String> selectedEmails = {};

  @override
  void onInit() {
    super.onInit();
    filteredUsers = List.from(allUsers);
    emailController.addListener(() {
      filterUsersByQuery(emailController.text.toLowerCase());
    });
  }

  void filterUsersByQuery(String query) {
    filteredUsers = allUsers.where((user) {
      final name = user['name'].toLowerCase();
      final email = user['email'].toLowerCase();
      return name.contains(query) || email.contains(query);
    }).toList();
    update();
  }

  void toggleEmailSelection(String email, bool? isSelected) {
    isSelected == true
        ? selectedEmails.add(email)
        : selectedEmails.remove(email);
    update();
  }

  void handleSendInvites(BuildContext context) {
    Navigator.pop(context);
    showSnackBarMessage(context, "Invites sent to ${selectedEmails.length} members");
  }
}
