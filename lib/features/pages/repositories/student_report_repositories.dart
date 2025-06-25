import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_report_model.dart';
import 'package:student_project/features/services/api_cilent.dart';

class StudentReportRepositories extends GetxController {
  Future<StudentReportModel?> getStatistics() {
    return ApiClient.getStudentStatistics();
  }
}
