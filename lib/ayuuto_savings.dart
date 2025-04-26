import 'package:ayuuto_savings_app/src/view/screen/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AyuutoSavings extends StatelessWidget {
  const AyuutoSavings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:SignInScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),
          bodySmall: TextStyle(fontSize: 16 , fontWeight: FontWeight.normal)
        ),
      ),
    );
  }
}
