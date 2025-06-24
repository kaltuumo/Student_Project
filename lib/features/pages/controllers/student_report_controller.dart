import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_report_model.dart';
import 'package:student_project/features/pages/repositories/student_repositories.dart';

class StudentReportController extends GetxController {
  final StudentRepositories _studentRepository = StudentRepositories();

  final RxList<StudentReportModel> posts = <StudentReportModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    try {
      isLoading(true);
      final data = await _studentRepository.getStatistics();
      if (data != null)
        posts.assignAll([data]); // hal object, ku gali liis ahaan
    } catch (e) {
      Get.snackbar("Error", 'Fetch failed: $e');
    } finally {
      isLoading(false);
    }
  }
}
