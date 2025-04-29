import 'package:ayuuto_savings_app/src/view/screen/my_group.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/app_colors.dart';

class AyuutoSavings extends StatelessWidget {
  const AyuutoSavings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyGroupScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.themeColor,
        textTheme: _buildTextTheme(),
        elevatedButtonTheme: _buildElevatedButtonThemeData(),
        inputDecorationTheme: _buildInputDecorationTheme(),
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.borderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.red),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColor.borderColor),
      ),
      contentPadding: EdgeInsets.all(10),
      hintStyle: TextStyle(
        color: Colors.grey.shade500
      ),
      errorStyle: TextStyle(fontSize: 12),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.buttonColor,
        foregroundColor: AppColor.themeColor,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  TextTheme _buildTextTheme() {
    return TextTheme(
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
