
import 'package:ayuuto_savings_app/src/view/screen/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final TextEditingController _newPasswordETController = TextEditingController();
  final TextEditingController _confirmPasswordETController = TextEditingController();

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
                  decoration: InputDecoration(hintText: "New Password"),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _newPasswordETController,
                  decoration: InputDecoration(hintText: "Confirm Password"),
                ),
                SizedBox(height: 160),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                       Get.to(()=>SignUpScreen());
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
}
