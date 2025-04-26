import 'package:ayuuto_savings_app/src/view/screen/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/assetPath.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 150,),
            Text("WelCome!", style: Theme.of(context).textTheme.bodyMedium),
            Text("Sign in to your Account",
                style: Theme.of(context).textTheme.bodySmall),
            Spacer(),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Sign In"),
              ),
            ),
            SizedBox(height: 15,),
            SizedBox(
              width:double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(()=>SignUpScreen());
                },
                child: Text("Sign Up"),
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
