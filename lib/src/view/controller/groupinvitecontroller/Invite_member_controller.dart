import 'package:ayuuto_savings_app/core/api_path.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InviteMemberController extends GetxController {
  Future<void> inviteMember({
    required String adminId,
    required String groupId,
    required List<String> memberEmails,
    required BuildContext context,
  }) async {
    final Uri url = Uri.parse(ApiPath.inviteUserUrl(groupId));

    final Map<String, dynamic> body = {
      "adminUserId": adminId,
      "groupId": groupId,
      "listOfMemberEmails": memberEmails,
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      debugPrint("Request URL: $url");
      debugPrint("Request Body: ${jsonEncode(body)}");
      debugPrint("Response Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnackBarMessage(context, "Invitation successful:\n${decoded['message'] ?? 'Success'}");
      } else {
        final errorMsg = decoded['message'] ?? 'Unknown error';
        showSnackBarMessage(context, "Invitation failed: $errorMsg");
      }
    } catch (error) {
      showSnackBarMessage(context, "Something went wrong!");
      debugPrint("Error: $error");
    }
  }
}
