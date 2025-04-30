import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/MemberPaymentScreen/widgets/history_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/MemberPaymentScreen/widgets/pay_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/MemberPaymentScreen/widgets/quick_pay_container.dart';
import 'package:flutter/material.dart';

class MemberPaymentScreen extends StatelessWidget {
  const MemberPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PayContainer(
                    num: '\$500.00',
                    text: 'Upcomming Payment',
                  ),
                  PayContainer(
                    num: '\$499.00',
                    text: 'Total Contributed',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Quick Pay',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              QuickPayContainer(
                groupName: 'Saving Circle',
                paymentInfo: 'May payment ● Due May 15',
                amount: '\$500.00',
                timeLeft: '6 days left',
              ),
              const SizedBox(height: 5),
              QuickPayContainer(
                groupName: 'Saving Circle',
                paymentInfo: 'May payment ● Due May 15',
                amount: '\$500.00',
                timeLeft: '6 days left',
              ),
              const SizedBox(height: 20),
              Text(
                'Payment History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // prevent nested scroll
                  itemBuilder: (context, index) {
                    return const HistoryContainer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
