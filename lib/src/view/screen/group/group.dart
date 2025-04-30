import 'package:flutter/material.dart';

class ManageGroupsPage extends StatelessWidget {
  const ManageGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Groups', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: const Offset(0, 2)),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: 'Admin',
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'Member', child: Text('Member')),
                ],
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text('Active Groups', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Center(
                      child: Text('Completed', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const GroupCard(
            title: 'Savings Circle',
            members: '10 members',
            monthlyAmount: '\$500 monthly',
            roundInfo: 'Round 3 of 10',
            nextPayment: 'May 15, 2023',
            currentReceiver: 'Emily W.',
          ),
          const GroupCard(
            title: 'Monthly Boost',
            members: '6 members',
            monthlyAmount: '\$250 monthly',
            roundInfo: 'Round 2 of 6',
            nextPayment: 'May 20, 2023',
            currentReceiver: 'Michael T.',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Groups'),
          BottomNavigationBarItem(icon: Icon(Icons.payment_outlined), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.supervisor_account_outlined), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String title;
  final String members;
  final String monthlyAmount;
  final String roundInfo;
  final String nextPayment;
  final String currentReceiver;

  const GroupCard({
    super.key,
    required this.title,
    required this.members,
    required this.monthlyAmount,
    required this.roundInfo,
    required this.nextPayment,
    required this.currentReceiver,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 4),
          Text('$members • $monthlyAmount', style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Round', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(roundInfo, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Next Payment', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(nextPayment, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Receiver', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(currentReceiver, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_1_outlined, size: 18),
                label: const Text('Invite'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey.shade200,
                  elevation: 0,
                ),
              ),
              const Text('Active', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
