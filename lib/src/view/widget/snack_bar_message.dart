import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String message,
    [bool isErrorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message,style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: Colors.white
      ),),
      backgroundColor: isErrorMessage ? AppColor.buttonColor : null,
    ),
  );
}