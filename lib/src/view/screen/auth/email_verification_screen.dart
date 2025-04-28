import 'package:ayuuto_savings_app/src/view/screen/auth/reset_password_screen.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/firebase/firebase_service.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailETController = TextEditingController();
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
                  controller: _emailETController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) =>
                      validateField(value: value, fieldType: "email"),
                ),
                SizedBox(height: 180),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        send();
                      }
                    },
                    child: Text("Reset Password"),
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
    _emailETController.dispose();
    super.dispose();
  }

  void send() async {
    try {
      bool isVerificationSent = await _firebaseService.sendEmailVerification();

      if (isVerificationSent) {
        showSnackBarMessage(
          context,
          "Verification email sent! Please check your inbox.",
        );
        Get.to(() => ResetPassword());
      } else {
        showSnackBarMessage(
          context,
          "Failed to send verification email. Please try again.",
        );
      }
    } catch (e) {
      showSnackBarMessage(
        context,
        "An error occurred: ${e.toString()}",
      );
    }
  }

  String? validateField({
    required String? value,
    required String fieldType,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldType';
    }

    if (fieldType == 'email') {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }

    if (fieldType == 'password') {
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      }
    }

    return null;
  }
}
