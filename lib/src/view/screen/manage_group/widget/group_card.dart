import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        memberCount,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        amount,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              if (!isCompleted)
                IconButton(
                  style: IconButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  onPressed: onInvitePressed,
                  icon: Row(
                    children: [
                      const Icon(Icons.person_outline_outlined),
                      Text(
                        "Invite",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w400 , fontSize: 12),
                      ),
                    ],
                  ),
                ),

              if (!isCompleted)
                Text(
                  "Active",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                ),

              if (isCompleted)
                Text(
                  "Completed",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 12),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Round",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey , fontSize: 12),
                  ),
                  Text(
                    roundProgress,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold,fontSize: 12),
                  ),
                ],
              ),
              if (!isCompleted)
                Column(
                  children: [
                    Text(
                      "Next Payment",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey,fontSize: 12),
                    ),
                    Text(
                      nextPayment,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w500 , fontSize: 14),
                    ),
                  ],
                ),
              // Show currentReceiver for active groups
              if (!isCompleted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Receiver",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey,fontSize: 12),
                    ),
                    Text(
                      currentReceiver,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500 , fontSize: 14
                      ),
                    ),
                  ],
                ),

              if (isCompleted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                    Text(
                      totalAmount,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
