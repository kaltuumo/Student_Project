import 'package:flutter/material.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class CustomButtons extends StatelessWidget {
  final String text;

  final Function()? onTap;
  const CustomButtons({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: AppSizes.lg,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
