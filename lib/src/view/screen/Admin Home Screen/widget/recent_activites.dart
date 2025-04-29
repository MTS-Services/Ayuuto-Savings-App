import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({
    super.key,
  });

  // Reusable widget for activity container
  Widget _buildActivityContainer(
      {required String title, required String subtitle, required String time, BorderRadius? borderRadius}) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.zero,
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.1),
            child: Icon(
              Iconsax.user,
              size: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                const SizedBox(height: 5),
                Text(
                  '$subtitle - $time',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildActivityContainer(
          title: 'New member joined group "Saving Circle"',
          subtitle: 'John Doe',
          time: '2 hours ago',
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        _buildActivityContainer(
          title: 'Jane Smith',
          subtitle: 'Sarrah Johnson',
          time: '2 hours ago',
        ),
        _buildActivityContainer(
          title: 'Rotation order updated for group "Investment Pool"',
          subtitle: 'Admin',
          time: 'yesterday',
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ],
    );
  }
}
