import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showMenu;
  final VoidCallback? onMenuTap;

  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.showMenu = false,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.xl,
          color: AppColors.blackColor,
        ),
      ),
      centerTitle: true,
      leading:
          showMenu
              ? IconButton(
                icon: const Icon(Icons.menu, color: AppColors.blackColor),
                onPressed: onMenuTap ?? () => Scaffold.of(context).openDrawer(),
              )
              : IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
                onPressed: () => Get.back(),
              ),
      actions: actions,
      backgroundColor: AppColors.whiteColor,
      elevation: 0, // No shadow (no divider)
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
