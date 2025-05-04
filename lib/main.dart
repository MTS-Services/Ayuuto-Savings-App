import 'package:ayuuto_savings_app/src/view/screen/StripePaymentScreen/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'ayuuto_savings.dart';
import 'firebase_options.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AyuutoSavings());
}

