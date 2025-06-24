// add_student.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/controllers/student_controller.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/attendence/daily_attendance.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/images.dart';
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

  // Dropdown values for Primary and Secondary
  final List<String> _educationLevels = ['Primary', 'Secondary'];

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
                Get.to(() => DailyAttendance());

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
          _buildLabel("Phone"),
          _buildTextFieldPhone(
            studentController.phoneController,
            'Phone Number',
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 24),
          _buildLabel("Education Level"),
          _buildDropdown(),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: studentController.createStudent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Create Student",
                style: TextStyle(color: AppColors.blackColor),
              ),
            ),
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

  Widget _buildTextFieldPhone(
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
        // Custom prefix inside the TextField
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: AppSizes.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
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

  // Dropdown to select Education Level

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value:
              studentController.selectedEducation.value.isNotEmpty
                  ? studentController.selectedEducation.value
                  : null, // if the value is empty, keep it null
          hint: const Text('Select Education Level'),
          isExpanded: true,
          onChanged: (String? newValue) {
            studentController.selectedEducation.value = newValue!;
          },
          items:
              _educationLevels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
      ),
    );
  }
}
