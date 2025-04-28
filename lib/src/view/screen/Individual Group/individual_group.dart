import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'widget/custom_appbar.dart';

class IndividualGroup extends StatelessWidget {
  const IndividualGroup({super.key, required this.groupName});
  final String groupName;

  @override
  Widget build(BuildContext context) {
    List<String> winners = [
      'Ali',
      'Fatima',
      'Omar',
      'Ayaan',
      'Hana',
      'Khalid',
      'Muna',
      'Yusuf',
      'Layla',
      'Amir',
      'Nora',
      'Salman',
      'Samira',
      'Bilal',
      'Imran',
      'Rania',
      'Sara',
      'Hussein',
      'Maya',
      'Adam'
    ];

    List<String> dates = [
      '2025-05-01',
      '2025-06-01',
      '2025-07-01',
      '2025-08-01',
      '2025-09-01',
      '2025-10-01',
      '2025-11-01',
      '2025-12-01',
      '2026-01-01',
      '2026-02-01',
      '2026-03-01',
      '2026-04-01',
      '2026-05-01',
      '2026-06-01',
      '2026-07-01',
      '2026-08-01',
      '2026-09-01',
      '2026-10-01',
      '2026-11-01',
      '2026-12-01'
    ];

    return Scaffold(
      appBar: CustomAppBar(title: groupName),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Winners and Dates',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Divider(thickness: 2),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: winners.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Icon(Iconsax.award,
                                    color: AppColor.buttonColor),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    winners[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Vertical Divider
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.grey,
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.calendar,
                                    color: AppColor.buttonColor),
                                const SizedBox(width: 5),
                                Text(
                                  dates[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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