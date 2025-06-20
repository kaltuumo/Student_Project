import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppbar({Key? key, required this.title, this.onBack})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: AppSizes.xl,
          // fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
        onPressed: onBack ?? () => Get.back(),
      ),
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          color: AppColors.blackColor.withOpacity(0.5),
          thickness: 1,
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
