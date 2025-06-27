// add_student.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/controllers/class_time_controller.dart';
import 'package:student_project/features/pages/models/class_time_model.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/student/add_student.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class UpdateClassTime extends StatefulWidget {
  final ClassTimeModel classes;

  const UpdateClassTime({super.key, required this.classes});

  @override
  State<UpdateClassTime> createState() => _UpdateClassTimeState();
}

class _UpdateClassTimeState extends State<UpdateClassTime> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ClassTimeController classTimeController = Get.put(
    ClassTimeController(),
  );

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
    classTimeController.subjectController.text = widget.classes.subject;
    classTimeController.teacherController.text = widget.classes.teacher;
    classTimeController.roomController.text = widget.classes.room;
    classTimeController.startTimeController.text = widget.classes.startTime;
    classTimeController.endTimeController.text = widget.classes.endTime;
    classTimeController.selectedDay.value = widget.classes.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Update Class'),
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
          _buildLabel("Subject"),
          _buildTextField(
            classTimeController.subjectController,
            'Enter Subject',
          ),

          // const SizedBox(height: 24),
          // _buildLabel("Gender"),
          // Obx(
          //   () => Row(
          //     children: [
          //       _buildRadio(classTimeController.teacherController),
          //       const SizedBox(width: 20),
          //       _buildRadio(studentController.selectedGender, 'Female'),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 24),
          _buildLabel("Teacher"),
          _buildTextField(
            classTimeController.teacherController,
            'Enter Teacher',
          ),

          const SizedBox(height: 24),
          _buildLabel("Room"),
          _buildTextField(classTimeController.roomController, 'Enter Room'),

          const SizedBox(height: 24),
          _buildLabel("Day Level"),
          _buildDropdown(),

          const SizedBox(height: 24),
          _buildLabel("Start Time"),
          _buildTextField(
            classTimeController.startTimeController,
            'Enter Start Time',
          ),

          const SizedBox(height: 24),
          _buildLabel("End Time"),
          _buildTextField(
            classTimeController.endTimeController,
            'Enter End Time',
          ),

          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () {
                classTimeController.updateClassTime();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Update Class",
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
              classTimeController.selectedDay.value.isNotEmpty
                  ? classTimeController.selectedDay.value
                  : null, // if the value is empty, keep it null
          hint: const Text('Select Day'),
          isExpanded: true,
          onChanged: (String? newValue) {
            classTimeController.selectedDay.value = newValue!;
          },
          items:
              [
                'Saturday',
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
              ].map<DropdownMenuItem<String>>((String value) {
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
