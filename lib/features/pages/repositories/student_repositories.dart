import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/services/api_cilent.dart';

class StudentRepositories {
  Future<bool> createStudent(StudentModel post) {
    return ApiClient.createStudent(post);
  }
}
