import 'package:ayuuto_savings_app/src/view/screen/auth/email_verification_screen.dart';
import 'package:ayuuto_savings_app/src/view/screen/auth/sign_up_screen.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/firebase_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  late TextEditingController _emailETController = TextEditingController();
  late TextEditingController _passwordETController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailETController.text = "example@gmail.com";
    _passwordETController.text = "Mdt@123@";
    super.initState();
  }


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
                  height: 150,
                ),
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _emailETController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) =>
                      validateField(value: value, fieldType: 'email'),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordETController,
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) =>
                      validateField(value: value, fieldType: 'password'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => EmailVerificationScreen());
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        signIn();
                      }
                    },
                    child: Text("Sing In"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text(
                        "Sing Up",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
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
    _passwordETController.dispose();

    _emailETController.dispose();

    super.dispose();
  }

  void signIn() async {
    try {
      bool isSignedIn = await _firebaseService.signInUser(
        email: _emailETController.text.trim(),
        password: _passwordETController.text,
      );

      if (isSignedIn) {
        showSnackBarMessage(context, "Login successful!");
      } else {
        showSnackBarMessage(context, "Login failed. Please check your credentials.");
      }
    } catch (e) {
      showSnackBarMessage(context, "An error occurred: ${e.toString()}");
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
