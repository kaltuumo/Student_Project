import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:student_project/features/auth/controllers/auth_controller.dart';
import 'package:student_project/features/auth/screens/admin/login_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/student/add_student.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/shared/widgets/custom_buttons.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/images.dart';
import 'package:student_project/utils/constant/sizes.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({super.key});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // final StudentController studentController = Get.put(StudentController());

    bool isDarkMode = false;

    // Method to toggle dark/light mode
    void toggleTheme() {
      setState(() {
        isDarkMode = !isDarkMode;
      });
      // Update the theme (if using GetX or another state manager, use that to change the theme)
      if (isDarkMode) {
        Get.changeTheme(ThemeData.dark());
      } else {
        Get.changeTheme(ThemeData.light());
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Add New Admin'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
            onPressed: toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Dashboard Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Add Student'),
              leading: const Icon(Icons.person_add),
              onTap: () {
                Get.to(() => const AddStudent());
                // Navigate to Add Student Screen
              },
            ),
            ListTile(
              title: const Text('All Students'),
              leading: const Icon(Icons.list),
              onTap: () {
                Get.to(() => GetStudent());
                // Navigate to All Students Screen
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text('Student Report'),
              leading: const Icon(Icons.report),
              onTap: () {
                // Navigate to Student Report Screen
              },
            ),
            ListTile(
              title: const Text('Daily Attendance'),
              leading: const Icon(Icons.access_time),
              onTap: () {
                // Navigate to Attendance Screen
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text('Attendance Report'),
              leading: const Icon(Icons.picture_as_pdf),
              onTap: () {
                // Navigate to Attendance Report Screen
              },
            ),
            ListTile(
              title: const Text('Admin Profile'),
              leading: const Icon(Icons.account_circle),
              onTap: () {
                Get.to(() => AdminProfile());
              },
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text('Add New Admin'),
              leading: const Icon(Icons.admin_panel_settings),
              onTap: () {
                Get.to(
                  () => const AddAdmin(),
                ); // Replace with actual Add Admin Screen
                // Navigate to Add New Admin Screen
              },
            ),
            ListTile(
              title: const Text('Manage Class Time'),
              leading: const Icon(Icons.schedule),
              onTap: () {
                // Navigate to Manage Class Time Screen
              },
            ),
          ],
        ),
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
