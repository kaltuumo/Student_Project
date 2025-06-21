// add_student.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/controllers/student_controller.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/utils/constant/sizes.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StudentController studentController = Get.put(StudentController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Add Student'),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          const Text(
            'Create a Student',
            style: TextStyle(
              fontSize: AppSizes.xxl,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          _buildLabel("Full Name"),
          _buildTextField(
            studentController.fullnameController,
            'Enter Full Name',
          ),

          const SizedBox(height: 24),
          _buildLabel("Gender"),
          Obx(
            () => Row(
              children: [
                _buildRadio(studentController.selectedGender, 'Male'),
                const SizedBox(width: 20),
                _buildRadio(studentController.selectedGender, 'Female'),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _buildLabel("Required"),
          _buildTextField(
            studentController.requiredController,
            'Enter Required',
          ),

          const SizedBox(height: 24),
          _buildLabel("Paid"),
          _buildTextField(studentController.paidController, 'Enter Paid'),

          const SizedBox(height: 24),
          _buildLabel("Remaining"),
          _buildTextField(
            studentController.remainingController,
            'Enter Remaining',
          ),

          const SizedBox(height: 24),
          _buildLabel("Phone"),
          _buildTextField(
            studentController.phoneController,
            'Phone Number',
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: studentController.createStudent,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Create Student"),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: AppSizes.md, color: Colors.grey),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget _buildRadio(RxString selectedGender, String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedGender.value,
          onChanged: (val) {
            selectedGender.value = val!;
          },
        ),
        Text(value, style: const TextStyle(fontSize: AppSizes.md)),
      ],
    );
  }
}
