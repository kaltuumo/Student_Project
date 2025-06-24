import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_project/features/pages/models/attendence_model.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/services/api_cilent.dart';

class AttendanceController extends GetxController {
  var students = <StudentModel>[].obs;
  var attendanceMap = <String, String>{}.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  // Fetch students for attendance
  void fetchStudents() async {
    try {
      isLoading.value = true;
      final data = await ApiClient.getStudents();
      students.value = data.map((e) => StudentModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", "Failed to load students: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Set attendance status for each student
  void setStatus(String studentId, String status) {
    attendanceMap[studentId] = status;
  }

  // Submit attendance to API
  void submitAttendance() async {
    final date = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime.now()); // Get today's date

    try {
      for (var student in students) {
        final status =
            attendanceMap[student.id] ?? 'Absent'; // Default status is 'Absent'

        final attendance = AttendanceModel(
          studentId: student.id!, // Using student's id
          date: date,
          status: status,
        );

        final success = await ApiClient.markAttendance(
          attendance,
        ); // Send attendance

        if (!success) {
          Get.snackbar("Error", "Failed for ${student.fullname}");
          return;
        }
      }

      Get.snackbar("Success", "Attendance marked for $date");
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
    }
  }

  void exportToPdf() {
    Get.snackbar("Export", "PDF export feature to be implemented");
  }
}
