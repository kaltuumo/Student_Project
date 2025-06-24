import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure GetX is imported
import 'package:student_project/features/pages/controllers/attendance_controller.dart'; // Import the AttendanceController

class DailyAttendance extends StatelessWidget {
  const DailyAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller using GetX
    final AttendanceController controller = Get.put(AttendanceController());

    return Scaffold(
      appBar: AppBar(title: Text("Daily Attendance")),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.students.length,
          itemBuilder: (context, index) {
            final student = controller.students[index];
            return Card(
              child: ListTile(
                title: Text(student.fullname),
                trailing: ToggleButtons(
                  children: [Text("P"), Text("A")],
                  isSelected: [
                    student.status ==
                        'Present', // Check if the status is 'Present'
                    student.status ==
                        'Absent', // Check if the status is 'Absent'
                  ],
                  onPressed: (i) {
                    // When the button is pressed, set the status to 'Present' or 'Absent'
                    if (i == 0) {
                      controller.setStatus(student.id!, 'Present');
                    } else {
                      controller.setStatus(student.id!, 'Absent');
                    }
                    // Refresh the state so only one button is selected at a time
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.submitAttendance, // Submit attendance
        child: Icon(Icons.save),
      ),
    );
  }
}
