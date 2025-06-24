import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/controllers/student_report_controller.dart';

class StudentReport extends StatelessWidget {
  final StudentReportController studentReportController = Get.put(
    StudentReportController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student Statistics')),
      body: Obx(() {
        if (studentReportController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final data = studentReportController.posts;
        if (data.isEmpty) {
          return Center(child: Text('No data found'));
        }

        final stats = data.first;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildStatCard("Total Students", stats.totalStudents),
              buildStatCard("Active Students", stats.activeStudents),
              buildStatCard("Inactive Students", stats.inactiveStudents),
              buildStatCard("Paid Students", stats.paidStudents),
              buildStatCard("Fully Paid", stats.fullyPaidStudents),
              buildStatCard("Balance Due", stats.balanceDueStudents),
            ],
          ),
        );
      }),
    );
  }

  Widget buildStatCard(String title, int value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
