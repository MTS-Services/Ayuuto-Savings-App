import 'package:ayuuto_savings_app/src/model/firebase_service.dart';
import 'package:ayuuto_savings_app/src/view/screen/auth/sign_in_screen.dart';

import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _newPasswordETController =
      TextEditingController();
  final TextEditingController _confirmPasswordETController =
      TextEditingController();
  final TextEditingController _emailTeController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                ),
                Text(
                  "Reset Your Password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _newPasswordETController,
                  decoration: InputDecoration(hintText: "new Password"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _confirmPasswordETController,
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                SizedBox(height: 160),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      resetPassword();
                    },
                    child: Text("Sign In"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newPasswordETController.dispose();
    _confirmPasswordETController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    try {
      if (_confirmPasswordETController.text != _newPasswordETController.text) {
        showSnackBarMessage(
            context, 'New password and confirm password do not match.');
        return;
      }
      bool isPasswordChanged = await _firebaseService.changePassword(
        email: _emailTeController.text.trim(),
        currentPassword: _newPasswordETController.text,
        newPassword: _confirmPasswordETController.text,
      );
      if (isPasswordChanged) {
        showSnackBarMessage(context, 'Password changed successfully!');
        Get.to(() => SignInScreen());
      }
      if(!isPasswordChanged){

        showSnackBarMessage(
            context, 'Password change failed. Please try again.');

      }
    } catch (e) {
      showSnackBarMessage(context, 'Error: ${e.toString()}');
    }
  }
}
