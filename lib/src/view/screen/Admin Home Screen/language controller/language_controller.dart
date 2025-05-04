// lib/src/controller/language_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var isEnglish = true.obs;

  void toggleLanguage(bool value) {
    isEnglish.value = value;
    Get.updateLocale(Locale(value ? 'en' : 'so'));
  }
}
