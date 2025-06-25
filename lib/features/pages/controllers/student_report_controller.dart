import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_report_model.dart';
import 'package:student_project/features/pages/repositories/student_report_repositories.dart';

class StudentReportController extends GetxController {
  final StudentReportRepositories studentReportRepositories = Get.put(
    StudentReportRepositories(),
  );

  final Rxn<StudentReportModel> report = Rxn<StudentReportModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    try {
      isLoading(true);
      var data = await studentReportRepositories.getStatistics();
      if (data != null) {
        report.value = data;
        print('Fetched Data: ${data.toString()}'); // Log data for debugging
      }
    } catch (e) {
      Get.snackbar("Error", 'Fetch Failed $e');
    } finally {
      isLoading(false);
    }
  }
}
