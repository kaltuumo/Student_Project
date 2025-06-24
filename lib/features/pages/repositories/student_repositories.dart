import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/models/student_report_model.dart';
import 'package:student_project/features/services/api_cilent.dart';

class StudentRepositories {
  Future<bool> createStudent(StudentModel post) {
    return ApiClient.createStudent(post);
  }

  Future<List<StudentModel>> fetchStudents() async {
    final postsData = await ApiClient.getStudents(); // API call
    print("✅ JSON DATA: $postsData"); // Ku dar tan si aad u hubiso xogta

    return postsData
        .map<StudentModel>((json) => StudentModel.fromJson(json))
        .toList();
  }

  Future<List<StudentModel>> fetchPending() async {
    final postsData = await ApiClient.getPending(); // API call
    print("✅ JSON DATA: $postsData"); // Ku dar tan si aad u hubiso xogta

    return postsData
        .map<StudentModel>((json) => StudentModel.fromJson(json))
        .toList();
  }

  Future<StudentReportModel?> getStatistics() {
    return ApiClient.getStudentStatistics();
  }

  Future<bool> updateStudent(String id, StudentModel student) {
    return ApiClient.updateStudent(id, student);
  }

  // Delete a post by id
  Future<bool> deleteStudent(String id) {
    return ApiClient.deletePost(id);
  }
}
