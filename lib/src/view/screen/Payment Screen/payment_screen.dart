import 'package:ayuuto_savings_app/src/view/screen/Individual%20Group/widget/custom_appbar.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment%20Screen/widgets/calender_tile_widget.dart';
import 'package:ayuuto_savings_app/src/view/screen/Payment%20Screen/widgets/remainder_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: CustomAppBar(title: 'Payment Management'),
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
                child: const TabBar(
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
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    // For "Upcoming" tab
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CalenderTileWidget(
                              isFirstContainerSelected:
                                  isFirstContainerSelected,
                              isSecondContainerSelected:
                                  isSecondContainerSelected,
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                ArrowContainer(
                                  icon: Icons.arrow_back_ios,
                                ),
                                Text('May 2023',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                                ArrowContainer(
                                  icon: Icons.arrow_forward_ios,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 1, // Number of items in the list
                            itemBuilder: (context, index) {
                              return const RemainderContainer();
                            },
                          ),
                        ),
                      ],
                    ),
                    // For "Completed" tab (you can use a similar layout for the second tab if needed)
                    Container(
                      child: Center(
                        child: Text('Completed Payments',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
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

class ArrowContainer extends StatelessWidget {
  const ArrowContainer({
    super.key,
    required this.icon,
  });
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Icon(icon, color: Colors.black, size: 20),
    );
  }
}
