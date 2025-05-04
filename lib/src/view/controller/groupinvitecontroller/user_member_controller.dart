import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/api_path.dart';
import '../../../model/userinvitemodel/group_user.dart';
import '../../widget/snack_bar_message.dart';
import 'invite_member_controller.dart';

class InviteController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final InviteMemberController inviteMemberController = Get.put(InviteMemberController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxList<Users> allUsers = <Users>[].obs;
  RxList<Users> filteredUsers = <Users>[].obs;
  RxSet<String> selectedEmails = <String>{}.obs;

  var isInProgress = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(() {
      filterUsersByQuery(emailController.text.toLowerCase());
    });

    groupUser();
  }

  Future<void> groupUser() async {
    try {
      isInProgress.value = true;

      final uri = Uri.parse(ApiPath.groupUserUrl);
      final response = await http.get(uri);

      debugPrint("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);

        if (decoded.containsKey('data') &&
            decoded['data'] is Map &&
            decoded['data']['users'] is List) {
          final List<dynamic> jsonData = decoded['data']['users'];

          final users = jsonData.map((json) => Users.fromJson(json)).toList();

          allUsers.assignAll(users);
          filteredUsers.assignAll(users);
        } else {
          debugPrint("Invalid response format.");
        }
      } else {
        debugPrint("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching users: $e");
    } finally {
      isInProgress.value = false;
    }
  }

  void filterUsersByQuery(String query) {
    filteredUsers.value = allUsers.where((user) {
      final name = user.name?.toLowerCase() ?? '';
      final email = user.email?.toLowerCase() ?? '';
      return name.contains(query) || email.contains(query);
    }).toList();
  }

  void toggleEmailSelection(String email, bool? isSelected) {
    if (isSelected == true) {
      selectedEmails.add(email);
    } else {
      selectedEmails.remove(email);
    }
  }
  Future<void> handleSendInvites(BuildContext context, String groupId) async {
    if (selectedEmails.isEmpty) {
      showSnackBarMessage(context, "Please select at least one user to invite.");
      return;
    }

    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      showSnackBarMessage(context, "User not logged in.");
      return;
    }

    final adminId = currentUser.uid;
    final emailsToSend = selectedEmails.toList();

    debugPrint("Sending invites from adminId: $adminId");
    debugPrint("Selected Emails: $emailsToSend");

    await inviteMemberController.inviteMember(
      adminId: adminId,
      groupId: groupId,
      memberEmails: emailsToSend,
      context: context,
    );

    Navigator.pop(context);
    showSnackBarMessage(context, "Invites sent to ${emailsToSend.length} members.");
  }


  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
