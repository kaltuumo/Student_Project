// add_student.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/auth/controllers/auth_controller.dart';
import 'package:student_project/features/pages/controllers/class_dropdown_controller.dart';
import 'package:student_project/features/pages/controllers/student_controller.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/student/add_student.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class UpdateStudent extends StatefulWidget {
  final StudentModel student;

  const UpdateStudent({super.key, required this.student});

  @override
  State<UpdateStudent> createState() => _UpdateStudenttState();
}

class _UpdateStudenttState extends State<UpdateStudent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StudentController studentController = Get.put(StudentController());
  final AuthController authController = Get.find<AuthController>();
  final classController = Get.put(ClassDropdownController());

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
  void initState() {
    super.initState();
    // Populate the fields with the existing data
    studentController.fullnameController.text = widget.student.fullname;
    studentController.phoneController.text = widget.student.phone;
    studentController.requiredController.text =
        widget.student.required.toString();
    studentController.paidController.text = widget.student.paid.toString();
    studentController.selectedGender.value = widget.student.gender;
    studentController.selectedEducation.value = widget.student.education;

    // ✅ Set classStudent and update classLevels list
    classController.selectedClassStudent.value = widget.student.classStudent!;
    studentController.selectedClassStudent.value = widget.student.classStudent!;
    classController.updateClassStudent(
      widget.student.classStudent!,
    ); // This populates classLevels

    // ✅ Now you can safely assign classLevel
    classController.selectedClassLevel.value = widget.student.classLevel!;
    studentController.selectedClassLevel.value = widget.student.classLevel!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Update Student'),
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
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Obx(() {
                final String name = authController.fullname.value;
                final String email = authController.email.value;
                final String initial =
                    name.isNotEmpty
                        ? name[0].toUpperCase()
                        : '?'; // xarafka 1aad

                return Row(
                  children: [
                    // CircleAvatar with first letter
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      child: Text(
                        initial,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name.isNotEmpty ? 'Welcome, $name' : 'Dashboard Menu',
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: AppSizes.md,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          email.isNotEmpty ? email : 'No email provided',
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontSize: AppSizes.md,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
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
          _buildTextField(
            studentController.phoneController,
            'Phone Number',
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 24),
          _buildLabel("Education Level"),
          _buildDropdown(),
          const SizedBox(height: 24),
          _buildLabel("Class Level"),
          _buildDropdownClassStudent(),
          const SizedBox(height: 24),
          _buildLabel("Class Option"),
          _buildDropdownClassLevel(),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: studentController.updateStudent,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Update Student",
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
          underline: const SizedBox(),
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

  Widget _buildDropdownClassStudent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => DropdownButtonFormField<String>(
          value:
              classController.selectedClassStudent.value.isEmpty
                  ? null
                  : classController.selectedClassStudent.value,
          decoration: InputDecoration(
            hintText:
                'Class Time', // Yareynta balaca textfiledga lkn label wuu balaarina
            border: InputBorder.none,
          ),
          items:
              classController.classStudentList.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              classController.updateClassStudent(value);
              studentController.selectedClassStudent.value = value;
            }
          },
        ),
      ),
    );
  }

  Widget _buildDropdownClassLevel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => DropdownButtonFormField<String>(
          value:
              classController.selectedClassLevel.value.isEmpty
                  ? null
                  : classController.selectedClassLevel.value,
          decoration: InputDecoration(
            hintText: 'Class Level',
            border: InputBorder.none,
          ),
          items:
              classController.classLevels.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              classController.updateClassLevel(value);
              studentController.selectedClassLevel.value = value;
            }
          },
        ),
      ),
    );
  }
}
