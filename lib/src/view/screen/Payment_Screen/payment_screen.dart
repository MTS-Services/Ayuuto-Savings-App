import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment_Screen/widgets/arrow_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment_Screen/widgets/calender_tile_widget.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment_Screen/widgets/completed_container.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment_Screen/widgets/remainder_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Rx<bool> isFirstContainerSelected =
      true.obs; // Controls color of the first container
  Rx<bool> isSecondContainerSelected =
      false.obs; // Controls color of the second container
  final RxString selectedDateText =
      DateFormat('MMMM yyyy').format(DateTime.now()).obs;

  @override
  Widget build(BuildContext context) {
    print(selectedDateText.value);
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: CustomAppBar(title: 'payment_management'.tr),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'upcoming'.tr),
                    Tab(text: 'completed'.tr),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalenderTileWidget(
                    isFirstContainerSelected: isFirstContainerSelected,
                    isSecondContainerSelected: isSecondContainerSelected,
                    selectedDateText: selectedDateText,
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      ArrowContainer(
                        icon: Icons.arrow_back_ios,
                      ),
                      Obx(() => Text(
                            selectedDateText.value,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      ArrowContainer(
                        icon: Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // For "Upcoming" tab
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3, // Number of items in the list
                            itemBuilder: (context, index) {
                              return RemainderContainer(
                                totalAmount: '15',
                                savingCircleName: 'Saving Circle',
                                membersCount: '10',
                                dueAmount: '\$1000',
                                dueDate: 'Due May 15',
                                sendReminderText: 'Send Reminder',
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // For "Completed" tab (you can use a similar layout for the second tab if needed)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3, // Number of items in the list
                            itemBuilder: (context, index) {
                              return CompletedContainer(
                                userName: 'John Doe',
                                savingCircleInfo:
                                    'Saving Circle ● May 12, 2023',
                                amount: '\$500.00',
                                referenceNumber: '1234567890',
                                transfermethod: 'Cash',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
