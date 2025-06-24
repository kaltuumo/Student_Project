import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/controllers/student_controller.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/attendence/daily_attendance.dart';
import 'package:student_project/features/pages/screens/payments/get_pending.dart';
import 'package:student_project/features/pages/screens/student/add_student.dart';
import 'package:student_project/features/pages/screens/student/student_report.dart';
import 'package:student_project/features/pages/screens/student/update_student.dart';

class GetStudent extends StatefulWidget {
  const GetStudent({super.key});

  @override
  State<GetStudent> createState() => _GetStudentState();
}

class _GetStudentState extends State<GetStudent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StudentController studentController = Get.put(StudentController());

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
        title: const Text('All Students'),
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
              onTap: () {},
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
                if (studentController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (studentController.posts.isEmpty) {
                  return const Center(child: Text('No students found.'));
                }

                return ListView.builder(
                  itemCount: studentController.posts.length,
                  itemBuilder: (context, index) {
                    final student = studentController.posts[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          student.fullname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Registered: ${student.createdDate}"),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'update') {
                                      studentController.setSelectedPostId(
                                        student.id!,
                                      );
                                      Get.to(
                                        () => UpdateStudent(student: student),
                                      );
                                    } else if (value == 'delete') {
                                      _showDeleteConfirmationDialog(context);
                                      studentController.selectedPostId =
                                          student.id;
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
                                  icon: const Icon(Icons.more_vert),
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
                                      Icon(Icons.phone, size: 20),
                                      SizedBox(width: 10),
                                      Text("${student.phone}"),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  width: 100,
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
                                      Icon(Icons.person, size: 20),
                                      SizedBox(width: 10),
                                      Text("${student.gender}"),
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
                                      Icon(Icons.access_time, size: 20),
                                      SizedBox(width: 10),
                                      Text("${student.createdTime}"),
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
                                      Icon(Icons.date_range, size: 20),
                                      SizedBox(width: 10),
                                      Text("${student.createdDate}"),
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
                                  Icon(Icons.school, size: 20),
                                  SizedBox(width: 10),
                                  Text("${student.education}"),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Required"),
                                    Text(
                                      "\$${student.required}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Paid"),
                                    Text(
                                      "\$${student.paid}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Remaining"),
                                    Text(
                                      "\$${student.remaining}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(thickness: 2, indent: 1, endIndent: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [Text("Activity")]),
                                    Text(
                                      "\$${student.required}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            student.status == 'Approved'
                                                ? Colors.green.withOpacity(0.4)
                                                : Colors.orange.withOpacity(
                                                  0.4,
                                                ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        student.status,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                await studentController.deleteStudent(); // ✅ call delete
                studentController.fetchAllStudents(); // optional: refresh list
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
