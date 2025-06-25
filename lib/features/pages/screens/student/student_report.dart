import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/controllers/student_controller.dart';
import 'package:student_project/features/pages/controllers/student_report_controller.dart';
import 'package:student_project/features/pages/screens/admin/add_admin.dart';
import 'package:student_project/features/pages/screens/admin/admin_profile.dart';
import 'package:student_project/features/pages/screens/attendence/daily_attendance.dart';
import 'package:student_project/features/pages/screens/payments/get_pending.dart';
import 'package:student_project/features/pages/screens/student/add_student.dart';
import 'package:student_project/features/pages/screens/student/get_student.dart';
import 'package:student_project/utils/constant/sizes.dart';

class StudentReport extends StatefulWidget {
  const StudentReport({super.key});

  @override
  State<StudentReport> createState() => _StudentReportState();
}

class _StudentReportState extends State<StudentReport> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StudentReportController studentReportController = Get.put(
    StudentReportController(),
  );

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
        title: const Text('Students Report'),
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
        child: Obx(() {
          if (studentReportController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (studentReportController.report.value == null) {
            return const Center(child: Text('No students found.'));
          }

          final studentReport = studentReportController.report.value!;
          final activePercentage =
              (studentReport.activeStudents / studentReport.totalStudents) *
              100;
          final inactivePercentage =
              (studentReport.inactiveStudents / studentReport.totalStudents) *
              100;
          final paidPercentage =
              (studentReport.paidStudents / studentReport.totalStudents) * 100;
          final fullyPaidPercentage =
              (studentReport.fullyPaidStudents / studentReport.totalStudents) *
              100;
          final balanceDuePercentage =
              (studentReport.balanceDueStudents / studentReport.totalStudents) *
              100;
          final pendingPercentage =
              (studentReport.pendingStudent / studentReport.totalStudents) *
              100;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Student Statistics",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Summary based on ${studentReport.totalStudents} Students"),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        Icon(
                          Icons.directions_run,
                          size: 20,
                          color: Colors.green.withOpacity(0.7),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${studentReport.activeStudents}"),
                            Text("Active"),
                            Text(
                              "${activePercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey, // <-- halkan baa lagu beddelay
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pause_circle_filled,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${studentReport.inactiveStudents}"),
                            Text("In Active"),
                            Text(
                              "${inactivePercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple.withOpacity(0.5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified,
                          size: 20,
                          color: Colors.purple.withOpacity(0.7),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${studentReport.paidStudents}"),
                            Text("Approved"),
                            Text(
                              "${paidPercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.withOpacity(
                        0.4,
                      ), // <-- halkan baa lagu beddelay
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pending,
                          size: 20,
                          color: Colors.orange.withOpacity(0.7),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${studentReport.pendingStudent}"),
                            Text("Pending"),
                            Text(
                              "${pendingPercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(0.5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 20,
                          color: Colors.red.withOpacity(0.7),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${studentReport.fullyPaidStudents}"),
                            Text("Fully Paid"),
                            Text(
                              "${fullyPaidPercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(
                        0.4,
                      ), // <-- halkan baa lagu beddelay
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 20,
                          color: Colors.blue.withOpacity(0.7),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${studentReport.balanceDueStudents}"),
                            Text("Balance Due"),
                            Text(
                              "${balanceDuePercentage.toStringAsFixed(1)}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                "Overall Financial",
                style: TextStyle(
                  fontSize: AppSizes.lg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                // width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white, // <-- halkan baa lagu beddelay
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Financial Overview",
                      style: TextStyle(
                        fontSize: AppSizes.lg,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      indent: 1,
                      endIndent: 1,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Requires"),
                            Text(
                              "\$${studentController.totalRequired.toStringAsFixed(2)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Text("Total Paid"),
                            Text(
                              "\$${studentController.totalPaid.toStringAsFixed(2)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Remaining"),
                            Text(
                              "\$${studentController.totalRemaining.toStringAsFixed(2)}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            Text("Overall Paid %"),
                            Text(
                              "${studentController.totalPaidPercentage.toStringAsFixed(2)}%",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
