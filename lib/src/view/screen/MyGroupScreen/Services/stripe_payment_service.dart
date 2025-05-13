// lib/src/services/stripe_payment_service.dart

import 'dart:convert';
import 'package:ayuuto_savings_app/core/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;


class StripePaymentService {
  static Map<String, dynamic>? intentPaymentData;

  static Future<void> showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) {
        intentPaymentData = null;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print(error.toString() + stackTrace.toString());
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Stripe error: ${e.error.localizedMessage}');
      }
      showDialog(
        context: context,
        builder: (c) => const AlertDialog(content: Text('Cancelled')),
      );
    } catch (error, s) {
      if (kDebugMode) {
        print(s);
        print(error.toString());
      }
    }
  }

  static Future<Map<String, dynamic>?> makeIntentForPayment(
      String amountToBeCharged, String currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        'amount': (int.parse(amountToBeCharged) * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: paymentInfo,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (kDebugMode) {
        print('Stripe API response: ${response.body}');
      }

      return jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<void> paymentSheetInitialization(
      BuildContext context, String amountToBeCharged, String currency) async {
    try {
      intentPaymentData = await makeIntentForPayment(amountToBeCharged, currency);
      if (intentPaymentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: 'Comapany Name example',
          ),
        );
        showPaymentSheet(context);
      }
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
        print(e.toString());
      }
    }
  }
}
