import 'package:ayuuto_savings_app/navigation_menu.dart';
import 'package:ayuuto_savings_app/src/view/screen/auth/sign_up_screen.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/firebase/firebase_service.dart';
import 'email_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  late final TextEditingController _emailETController = TextEditingController();
  late final TextEditingController _passwordETController =
      TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailETController.text = "maktechsolutioncorporate@gmail.com";
    _passwordETController.text = "mdt@123@";
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
                  "sign_in".tr,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _emailETController,
                  decoration: InputDecoration(hintText: 'email'.tr),
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
                  decoration: InputDecoration(hintText: 'password'.tr),
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
                        'forgot_password'.tr,
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
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_globalKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                    child: _isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text('sign_in'.tr),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont_have_account'.tr,
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
                        'sign_up'.tr,
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
    setState(() {
      _isLoading = true;
    });
    try {
      bool isSignedIn = await _firebaseService.signInUser(
        email: _emailETController.text.trim(),
        password: _passwordETController.text,
      );

      if (isSignedIn) {
        final user = _firebaseService.auth.currentUser;

        if (user != null) {
          final userDoc = await _firebaseService.firestore
              .collection('users')
              .doc(user.uid)
              .get();

          final data = userDoc.data();
          print("Firestore data: $data");
          final role = userDoc.data()?['role'] ?? 'member';

          showSnackBarMessage(context, "Login successful!");
          print("Signed in as: ${user.email}");
          print(
              "Retrieved role from Firestore: $role (${userDoc.data()?['role']})");

          Get.offAll(() => NavigationMenu(userRole: role));
        }
      } else {
        showSnackBarMessage(
            context, "Login failed. Please check your credentials.");
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
