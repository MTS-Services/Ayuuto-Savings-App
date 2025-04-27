import 'package:ayuuto_savings_app/src/view/screen/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameETController = TextEditingController();
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _phoneETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

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
                  height: 150,
                ),
                Text(
                  "Sign UP",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _nameETController,
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _emailETController,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (value) => validateField(
                    value: value,
                    fieldType: "email",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _phoneETController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: "Phone"),
                  validator: (value) =>
                      validateField(value: value, fieldType: "phone"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordETController,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "password"),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {}
                    },
                    child: Text("Sing Up"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => SignInScreen());
                      },
                      child: Text(
                        "Sign In",
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
    _phoneETController.dispose();
    _emailETController.dispose();
    _nameETController.dispose();
    super.dispose();
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
