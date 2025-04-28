import 'package:ayuuto_savings_app/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomMemberTile extends StatelessWidget {
  final String memberName;
  final String joinDate;
  final String position;
  final String status;
  final Color statusColor;
  final Widget? leadingAvatar;

  const CustomMemberTile({
    Key? key,
    required this.memberName,
    required this.joinDate,
    required this.position,
    required this.status,
    this.statusColor = Colors.greenAccent,
    this.leadingAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingAvatar ?? const CircleAvatar(),
      title: Row(
        children: [
          Text(
            memberName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14
            ),
          ),
          SizedBox(width: 20,),
          Text(
            "Position: $position",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12
            )
          ),
        ],
      ),
      subtitle: Text(
            "Join Date: $joinDate",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12
            )
          ),

      trailing: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColor.activeColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
