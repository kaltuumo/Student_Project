import 'package:flutter/material.dart';
import 'package:student_project/utils/constant/sizes.dart';

class ProfileWidget extends StatelessWidget {
  final String text;
  final String subText;
  final IconData iconData;

  const ProfileWidget({
    super.key,
    required this.text,
    required this.subText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(iconData, size: AppSizes.iconLg),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: AppSizes.lg),
              ), // Tani waa magaca qaybta
              Text(
                subText, // Halkan waxaa lagu daabacayaa subText (sida taleefanka ama emailka)
                style: TextStyle(fontSize: AppSizes.lg, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
