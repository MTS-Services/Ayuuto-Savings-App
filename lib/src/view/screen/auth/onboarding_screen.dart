import 'package:ayuuto_savings_app/src/view/screen/AllUserScreen/language%20controller/language_controller.dart';
import 'package:ayuuto_savings_app/src/view/screen/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final LanguageController _languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Text('Welcome!'.tr, style: Theme.of(context).textTheme.bodyMedium),
            Text("Choose a Language",
                style: Theme.of(context).textTheme.bodySmall),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _languageController.toggleLanguage(true);
                  Get.to(() => SignInScreen());
                },
                child: Text('English'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _languageController.toggleLanguage(false);
                  Get.to(() => SignInScreen());
                },
                child: Text('Soomaali'),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
