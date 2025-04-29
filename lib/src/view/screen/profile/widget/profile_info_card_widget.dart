import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final String? text;

  const ProfileInfoCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = screenWidth * 0.5;
    double cardHeight = screenHeight * 0.12;

    double titleFontSize = screenWidth * 0.035;
    double countFontSize = screenWidth * 0.055;
    double iconSize = screenWidth * 0.06;
    double textFontSize = screenHeight * 0.017;

    return Container(
      padding: const EdgeInsets.all(12),
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: titleFontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.blue,
                    size: iconSize,
                  ),

                  if (text != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        text!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: textFontSize,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: countFontSize,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
