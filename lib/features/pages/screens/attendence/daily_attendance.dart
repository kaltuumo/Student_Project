import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_project/features/auth/controllers/auth_controller.dart';
import 'package:student_project/features/pages/controllers/attendance_controller.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class DailyAttendance extends StatefulWidget {
  DailyAttendance({super.key});

  @override
  State<DailyAttendance> createState() => _DailyAttendanceState();
}

class _DailyAttendanceState extends State<DailyAttendance> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController authController = Get.find<AuthController>();
  final AttendanceController controller = Get.put(AttendanceController());

  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    if (isDarkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat(
      'd MMMM yyyy',
    ).format(DateTime(2025, 7, 1));

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Daily Attendance'),
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
                    name.isNotEmpty ? name[0].toUpperCase() : '?';

                return Row(
                  children: [
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: 140,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today, size: 20),
                      SizedBox(width: 10),
                      Text(formattedDate),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField<String>(
                        value:
                            controller.selectedClassLevel.value.isEmpty
                                ? null
                                : controller.selectedClassLevel.value,
                        hint: Text("Select Class Level"),
                        isExpanded: true,
                        decoration: InputDecoration(border: InputBorder.none),
                        items:
                            controller.classLevels.map((String level) {
                              return DropdownMenuItem<String>(
                                value: level,
                                child: Text(level),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          controller.selectedClassLevel.value = newValue!;
                          controller.fetchStudentsInClass();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // List of students based on selected class level
            Obx(
              () =>
                  controller.studentsInClass.isEmpty
                      ? Text("No students found.")
                      : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.studentsInClass.length,
                        itemBuilder: (context, index) {
                          // Assuming controller.studentsInClass contains both name and phone
                          final studentDetails = controller
                              .studentsInClass[index]
                              .split(' - ');
                          final fullName = studentDetails[0];
                          final phone =
                              studentDetails.length > 1
                                  ? studentDetails[1]
                                  : 'No phone number';

                          return Card(
                            elevation: 1,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8),
                              leading: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              title: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Full Name Column
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fullName, // Display full name
                                          style: TextStyle(fontSize: 16),
                                          softWrap:
                                              true, // Allow text to wrap to the next line
                                        ),
                                        Text(
                                          phone, // Display phone number
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5,
                                      ),
                                      // width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.grey[800]
                                                : Colors.grey[400],
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection:
                                            Axis.horizontal, // Enable horizontal scrolling

                                        child: Row(
                                          children: [
                                            Icon(Icons.phone, size: 20),
                                            SizedBox(width: 10),

                                            Text(
                                              "|",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),

                                            SizedBox(width: 10),
                                            Icon(Icons.add),
                                            Icon(Icons.phone, size: 20),
                                            SizedBox(width: 10),

                                            Text(
                                              "|",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
