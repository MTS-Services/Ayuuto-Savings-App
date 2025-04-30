import 'package:flutter/material.dart';

class UserDataTable extends StatefulWidget {
  const UserDataTable({super.key});

  @override
  State<UserDataTable> createState() => _UserDataTableState();
}

class _UserDataTableState extends State<UserDataTable> {
  final List<Map<String, dynamic>> users = List.generate(3, (index) {
    return {
      'name': 'Jabed Jahangir',
      'email': 'user$index@example.com',
      'phone': '+252 61 000 00$index',
      'dob': '01-01-199${index % 10}',
      'groups': [
        'Family Saving',
        'Business Investment',
        'Emergency Fund',
        'Educational Savings'
      ].sublist(0, (index % 4) + 1),
    };
  });

  // Sample groups for dialog
  final List<Map<String, dynamic>> groups = [
    {'name': 'Family Saving', 'membersCount': 8, 'price': 100},
    {'name': 'Business Investment', 'membersCount': 5, 'price': 50},
    {'name': 'Emergency Fund', 'membersCount': 10, 'price': 150},
    {'name': 'Educational Savings', 'membersCount': 12, 'price': 80},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DataTable(
          columnSpacing: 30,
          headingRowHeight: 56,
          dataRowMinHeight: 0,
          dataRowMaxHeight: 130,
          columns: const [
            DataColumn(
                label: Text('Name',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Email',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Phone',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Date of birth',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Groups',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Action',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: users.map((user) {
            return DataRow(cells: [
              DataCell(SizedBox(
                width: 100,
                child: Text(user['name']!,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
              )),
              DataCell(Text(user['email']!,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16))),
              DataCell(Text(user['phone']!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
              DataCell(Text(user['dob']!,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: (user['groups'] as List<String>).map((group) {
                      return Text(group,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500));
                    }).toList(),
                  ),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          contentPadding: EdgeInsets.all(16),
                          insetPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          title: Text('Manage group membership',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          content: SizedBox(
                            width: 420,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    'Add or remove ${user['name']} from groups',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                                const SizedBox(height: 10),
                                for (var group in groups) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: user['groups']
                                            .contains(group['name']),
                                        onChanged: (value) {},
                                      ),
                                      Text(
                                        '${group['name']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                      Spacer(),
                                      Column(
                                        children: [
                                          Text(
                                            '${group['membersCount']} members',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            '\$${group['price']}/month',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Edit'),
                ),
              ),
            ]);
          }).toList(),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 200,
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'List of all registered users in the system',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 12),
                const SizedBox(
                  width: 200,
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
