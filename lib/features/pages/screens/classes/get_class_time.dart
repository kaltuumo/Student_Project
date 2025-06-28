import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_project/features/auth/controllers/auth_controller.dart';
import 'package:student_project/features/pages/controllers/class_time_controller.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/attendence/daily_attendance.dart';
import 'package:student_project/features/pages/screens/classes/update_class_time.dart';
import 'package:student_project/features/pages/screens/payments/get_pending.dart';
import 'package:student_project/features/pages/screens/student/add_student.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/features/pages/screens/student/student_report.dart';
import 'package:student_project/utils/constant/colors.dart';
import 'package:student_project/utils/constant/sizes.dart';

class GetClassTime extends StatefulWidget {
  const GetClassTime({super.key});

  @override
  State<GetClassTime> createState() => _GetClassTimeState();
}

class _GetClassTimeState extends State<GetClassTime> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthController authController = Get.find<AuthController>();
  final ClassTimeController classTimeController = Get.put(
    ClassTimeController(),
  );

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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('All Classes'),
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
              onTap: () => Get.to(() => AddStudent()),
            ),
            ListTile(
              title: const Text('All Students'),
              leading: const Icon(Icons.list),
              onTap: () => Get.to(() => const GetStudent()),
            ),
            Divider(thickness: 1, indent: 16, endIndent: 16),
            ListTile(
              title: const Text('Pending'),
              leading: const Icon(Icons.pending),
              onTap: () {
                Get.to(() => GetPending());
              },
            ),
            ListTile(
              title: const Text('Student Report'),
              leading: const Icon(Icons.report),
              onTap: () {
                Get.to(() => StudentReport());
              },
            ),
            ListTile(
              title: const Text('Daily Attendance'),
              leading: const Icon(Icons.access_time),
              onTap: () {
                Get.to(() => DailyAttendance());
              },
            ),
            Divider(thickness: 1, indent: 16, endIndent: 16),
            ListTile(
              title: const Text('Attendance Report'),
              leading: const Icon(Icons.picture_as_pdf),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Admin Profile'),
              leading: const Icon(Icons.account_circle),
              onTap: () => Get.to(() => AdminProfile()),
            ),
            Divider(thickness: 1, indent: 16, endIndent: 16),
            ListTile(
              title: const Text('Add New Admin'),
              leading: const Icon(Icons.admin_panel_settings),
              onTap: () => Get.to(() => AddAdmin()),
            ),
            ListTile(
              title: const Text('Manage Class Time'),
              leading: const Icon(Icons.schedule),
              onTap: () {
                Get.to(() => GetClassTime());
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search Box (optional)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[800]
                        : Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(child: Text('Search by name or phone...')),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Student List
            Expanded(
              child: Obx(() {
                if (classTimeController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (classTimeController.posts.isEmpty) {
                  return const Center(child: Text('No Classes found.'));
                }

                return ListView.builder(
                  itemCount: classTimeController.posts.length,
                  itemBuilder: (context, index) {
                    final classes = classTimeController.posts[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Row(
                          children: [
                            Text(
                              classes.teacher,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'update') {
                                      classTimeController.setSelectedPostId(
                                        classes.id!,
                                      );
                                      Get.to(
                                        () => UpdateClassTime(classes: classes),
                                      );
                                    } else if (value == 'delete') {
                                      _showDeleteConfirmationDialog(context);
                                      classTimeController.selectedPostId =
                                          classes.id;
                                    }
                                  },
                                  itemBuilder:
                                      (BuildContext context) => [
                                        const PopupMenuItem(
                                          value: 'update',
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              ), // Icon for Update
                                              SizedBox(
                                                width: 8,
                                              ), // Space between icon and text
                                              Text('Update'),
                                            ],
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: 'delete',

                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ), // Icon for Update
                                              SizedBox(
                                                width: 8,
                                              ), // Space between icon and text
                                              Text('Delete'),
                                            ],
                                          ),
                                        ),
                                      ],
                                ),
                              ],
                            ),
                            Divider(thickness: 2, indent: 1, endIndent: 1),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                      255,
                                      100,
                                      141,
                                      101,
                                    ).withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.subject, size: 20),
                                      SizedBox(width: 10),
                                      Text(classes.subject),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                      255,
                                      100,
                                      141,
                                      101,
                                    ).withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.room, size: 20),
                                      SizedBox(width: 10),
                                      Text(classes.room),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                      255,
                                      100,
                                      141,
                                      101,
                                    ).withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_today, size: 20),
                                      SizedBox(width: 10),
                                      Text(classes.day),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 125,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                      255,
                                      100,
                                      141,
                                      101,
                                    ).withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, size: 20),
                                      SizedBox(width: 10),
                                      Text(classes.startTime),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              width: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(
                                  255,
                                  100,
                                  141,
                                  101,
                                ).withOpacity(0.5),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time, size: 20),
                                  SizedBox(width: 10),
                                  Text(classes.endTime),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showClassFormBottomSheet(context);
        },
        backgroundColor: Colors.green,
        elevation: 6, // Hooska button-ka
        tooltip: 'Add New',
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void _showClassFormBottomSheet(BuildContext context) {
    final ClassTimeController classTimeController =
        Get.find<ClassTimeController>();
    final List<String> days = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: [
                Center(
                  child: Text(
                    "Add New Class Time",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 70),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: classTimeController.subjectController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Subject',
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: classTimeController.teacherController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Teacher',
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: classTimeController.roomController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Room',
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Day',
                    ),
                    value:
                        classTimeController.selectedDay.value.isNotEmpty
                            ? classTimeController.selectedDay.value
                            : null,
                    items:
                        days.map((String day) {
                          return DropdownMenuItem<String>(
                            value: day,
                            child: Text(day),
                          );
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        classTimeController.selectedDay.value = value;
                      }
                    },
                  ),
                ),

                const SizedBox(height: 70),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: classTimeController.startTimeController,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        // ✅ Use this for clear AM/PM formatting
                        final formattedTime = DateFormat(
                          'h:mm a',
                          'en_US',
                        ).format(dateTime);

                        classTimeController.startTimeController.text =
                            formattedTime;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select Start Time (AM/PM)',
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    controller: classTimeController.endTimeController,
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final dateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );

                        // ✅ Use this for clear AM/PM formatting
                        final formattedTime = DateFormat(
                          'h:mm a',
                          'en_US',
                        ).format(dateTime);

                        classTimeController.endTimeController.text =
                            formattedTime;
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select End Time (AM/PM)',
                    ),
                  ),
                ),

                const SizedBox(height: 70),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    classTimeController.createClassTime();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.save),
                  label: Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete this student?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cancel button
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close dialog
                await classTimeController.deleteClassTime(); // ✅ call delete
                classTimeController
                    .fetchAllClassTime(); // optional: refresh list
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
