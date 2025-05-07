import 'dart:convert';
import 'package:ayuuto_savings_app/core/api_path.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../model/creategroupmodel/group_create_model.dart';

class GroupCreateController extends GetxController {
  var isLoading = false.obs;

  Future<GroupModel?> groupCreate({
    required String adminUserId,
    required String groupName,
    required int contributionAmount,
    required String frequency,
    required int maxMembers,
    required String description,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    update();

    final url = Uri.parse(ApiPath.groupCreateUrl);

    final body = jsonEncode({
      "adminUserId": adminUserId,
      "groupName": groupName,
      "contributionAmount": contributionAmount,
      "frequency": frequency,
      "maxMembers": maxMembers,
      "description": description,

    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBarMessage(context, "Group created successfully");

        final jsonData = jsonDecode(response.body);
        return GroupModel.fromMap(jsonData, jsonData['groupId'] ?? '');
      } else {
        showSnackBarMessage(context, "Group creation failed: ${response.body}");
        return null;
      }
    } catch (e) {
      showSnackBarMessage(context, "Group creation error: $e");
      return null;
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
