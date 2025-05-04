import 'package:ayuuto_savings_app/core/api_path.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../widget/snack_bar_message.dart';

class SendInviteCode extends GetxController {
  var isInviting = false.obs;

  final String authToken = ApiPath.inviteCodeUrl;

  Future<bool> sendInvitation(
      BuildContext context,
      String invitationCode,
      String userId,
      ) async {
    final String apiUrl = ApiPath.inviteCodeUrl;

    final Map<String, String> data = {
      'invitationCode': invitationCode,
      'userId': userId,
    };

    try {
      isInviting.value = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(data),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        showSnackBarMessage(
          context,
          "Invitation sent successfully!",
        );
        return true;
      } else {
        showSnackBarMessage(
          context,
          "Failed to send invitation. Status Code: ${response.statusCode}",
        );
        return false;
      }
    } catch (e) {
      showSnackBarMessage(
        context,
        " Error sending invitation: $e",
      );
      return false;
    } finally {
      isInviting.value = false;
    }
  }
}
