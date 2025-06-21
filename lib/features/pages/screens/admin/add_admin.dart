import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:student_project/features/auth/controllers/auth_controller.dart';
import 'package:student_project/features/auth/screens/admin/login_admin.dart';
import 'package:student_project/shared/widgets/custom_buttons.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/images.dart';
import 'package:student_project/utils/constant/sizes.dart';

class AddAdmin extends StatelessWidget {
  const AddAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(AppImages.appLogoFull, width: 170, height: 170),
                SizedBox(height: 24),
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: AppSizes.xxl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please sign up to continue',
                  style: TextStyle(
                    fontSize: AppSizes.xl,
                    color: Colors.black54,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: AppSizes.md,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: authController.fullnameController,
                      decoration: InputDecoration(
                        hintText: 'Enter Full Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: AppSizes.md,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: authController.emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: AppSizes.md,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: authController.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.xs,
                            vertical: AppSizes.xs - 1,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: AppSizes.sm),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius,
                                ),
                                child: Image.asset(
                                  AppImages.somaliFlag,
                                  width: 45,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: AppSizes.xl),
                              Text(
                                '+252',
                                style: TextStyle(
                                  fontSize: AppSizes.lg,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              const SizedBox(width: AppSizes.xl),
                              Text(
                                '|',
                                style: TextStyle(
                                  color: AppColors.blackColor.withOpacity(0.25),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: AppSizes.md,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: authController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 46,
                      width: double.infinity,
                      child: CustomButtons(
                        text: "SignUp",
                        onTap: () async {
                          bool success = await authController.signupAdmin();

                          if (success) {
                            authController.clearSignupFields();
                            Get.offAll(() => LoginAdmin());
                          } else {
                            print('Signup failed, not navigating.');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: AppSizes.md),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => LoginAdmin());
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: AppSizes.lg,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
