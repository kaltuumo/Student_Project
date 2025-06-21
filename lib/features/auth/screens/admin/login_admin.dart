import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_project/features/auth/controllers/auth_controller.dart';
import 'package:student_project/features/pages/screens/dashboard/dashboard.dart';
import 'package:student_project/shared/widgets/custom_buttons.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/images.dart';
import 'package:student_project/utils/constant/sizes.dart'; // Make sure to import this for SharedPreferences

class LoginAdmin extends StatelessWidget {
  const LoginAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.appLogoFull, width: 170, height: 170),
                SizedBox(height: 10),
                const Text(
                  'Welcome to MaalPay',
                  style: TextStyle(
                    fontSize: AppSizes.xl,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please log in to continue',
                  style: TextStyle(
                    fontSize: AppSizes.md,
                    color: Colors.black54,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      "Password",
                      style: TextStyle(
                        fontSize: AppSizes.md,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GetBuilder<AuthController>(
                      builder: (controller) {
                        return TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(color: Colors.grey),
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
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      height: 46,
                      width: double.infinity,
                      child: CustomButtons(
                        text: "Login",
                        onTap: () async {
                          await authController
                              .loginAdmin(); // Corrected method name
                          // Check if token is saved and navigate accordingly
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? token = prefs.getString('token');
                          if (token != null) {
                            Get.offAll(() => Dashboard());
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
                      "Don't have an account?",
                      style: TextStyle(fontSize: AppSizes.md),
                    ),
                    TextButton(
                      onPressed: () {
                        // Get.to(() => ad());
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: AppSizes.md,
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
