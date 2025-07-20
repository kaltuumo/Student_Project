import 'package:flutter/material.dart';
import 'package:student_project/utils/constant/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({super.key, required this.title, this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,

      title: Text(
        title,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: isDark ? Colors.white : AppColors.primaryColor,
          ),
          onPressed: onNotificationTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
