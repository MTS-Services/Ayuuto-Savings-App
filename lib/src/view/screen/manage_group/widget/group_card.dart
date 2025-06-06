import 'package:flutter/material.dart';

import 'invite_bottom_sheet.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final String memberCount;
  final String amount;
  final String roundProgress;
  final String nextPayment;
  final String currentReceiver;
  final String totalAmount;
  final VoidCallback onInvitePressed;
  final bool isCompleted;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.memberCount,
    required this.amount,
    required this.roundProgress,
    required this.nextPayment,
    required this.currentReceiver,
    required this.totalAmount,
    required this.onInvitePressed,
    required this.isCompleted,
  });

  void _showInviteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const InviteBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        memberCount,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        amount,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              if (!isCompleted)
                IconButton(
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        width: 1,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  onPressed: () => _showInviteBottomSheet(context),
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.person_outline_outlined,
                        size: 20,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Invite",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

              if (!isCompleted)
                Text("Active", style: Theme.of(context).textTheme.bodySmall)
              else
                Text(
                  "Completed",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoColumn("Round", roundProgress, context),
              if (!isCompleted)
                _infoColumn("Next Payment", nextPayment, context, isBold: true),
              if (!isCompleted)
                _infoColumn("Current Receiver", currentReceiver, context,
                    isBold: true),
              if (isCompleted)
                _infoColumn("Total Amount", totalAmount, context, isBold: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value, BuildContext context,
      {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
                fontSize: 12,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
        ),
      ],
    );
  }
}
