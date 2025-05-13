import 'dart:convert';

import 'package:ayuuto_savings_app/core/api_path.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CreateController extends GetxController {
  late var isLoading = false.obs;


  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String dateOfBirth,
    required String password,
    required BuildContext context
  }) async {
    isLoading.value = true;

    final url = Uri.parse(ApiPath.userCreateUrl);

    final body = jsonEncode({
      "userId": uid,
      "name": name,
      "email": email,
      "dateOfBirth": dateOfBirth,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBarMessage(context, "User created successfully");
      } else {
        showSnackBarMessage(context, "Failed to create user: ${response.body}");
      }
    } catch (e) {
      showSnackBarMessage(context, "Failed to create user: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

