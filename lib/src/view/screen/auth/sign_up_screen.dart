import 'package:ayuuto_savings_app/src/model/firebase_service.dart';
import 'package:ayuuto_savings_app/src/view/screen/auth/sign_in_screen.dart';
import 'package:ayuuto_savings_app/src/view/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  final TextEditingController _nameETController = TextEditingController();
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _phoneETController = TextEditingController();
  final TextEditingController _dateOfBirthETController = TextEditingController();
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
                const SizedBox(height: 150),
                Text(
                  "Sign UP",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 50),

                TextFormField(
                  controller: _nameETController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "name"),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _emailETController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "email"),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _phoneETController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "Phone",
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "phone"),
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _dateOfBirthETController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: "Date of Birth",
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: pickDateOfBirth,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: _passwordETController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (value) =>
                      validateField(value: value, fieldType: "password"),
                ),
                const SizedBox(height: 50),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const SignInScreen());
                      },
                      child: const Text(
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
    _nameETController.dispose();
    _emailETController.dispose();
    _phoneETController.dispose();
    _dateOfBirthETController.dispose();
    _passwordETController.dispose();
    super.dispose();
  }

  void signUp() async {
    bool isSignedUp = await _firebaseService.signUpUser(
      email: _emailETController.text.trim(),
      password: _passwordETController.text,
    );

    if (isSignedUp) {
      showSnackBarMessage(context, "Account created successfully!");
      Get.to(() => const SignInScreen());
    } else {
      showSnackBarMessage(context, "Account creation failed. Please try again.");
    }
  }


  void pickDateOfBirth() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _dateOfBirthETController.text =
      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
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
