import 'package:ayuuto_savings_app/src/view/screen/Admin%20Home%20Screen/widget/custom_card.dart';
import 'package:flutter/material.dart';

class PayContainer extends StatelessWidget {
  const PayContainer({super.key, required this.text, required this.num});
  final String text;
  final String num;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      num: num,
      text: text,
    );
  }
}
