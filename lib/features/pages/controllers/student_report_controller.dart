import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/models/student_report_model.dart';
import 'package:student_project/features/pages/repositories/student_report_repositories.dart';
import 'package:student_project/features/pages/repositories/student_repositories.dart';

class StudentReportController extends GetxController {
  final StudentReportRepositories studentReportRepositories = Get.put(
    StudentReportRepositories(),
  );

  final RxList<StudentModel> posts = <StudentModel>[].obs;
  final Rxn<StudentReportModel> report = Rxn<StudentReportModel>();
  final StudentRepositories _studentRepository = StudentRepositories();
  final isLoading = false.obs;

  // Computed totals All Students
  int get totalRequired =>
      posts.fold(0, (sum, item) => sum + item.required.toInt());

  int get totalPaid => posts.fold(0, (sum, item) => sum + item.paid.toInt());

  int get totalRemaining =>
      posts.fold(0, (sum, item) => sum + (item.required - item.paid).toInt());

  double get totalPaidPercentage {
    double totalReq = totalRequired.toDouble();
    return (totalReq > 0) ? (totalPaid / totalReq) * 100 : 0;
  }

  // Computed totals All Male Students

  int get totalRequiredMale => posts
      .where((item) => item.gender == 'Male')
      .fold(0, (sum, item) => sum + item.required.toInt());

  int get totalPaidMale => posts
      .where((item) => item.gender == 'Male')
      .fold(0, (sum, item) => sum + item.paid.toInt());

  int get totalRemainingMale => posts
      .where((item) => item.gender == 'Male')
      .fold(0, (sum, item) => sum + (item.required - item.paid).toInt());

  double get totalPaidPercentageMale {
    double totalReq = totalRequiredMale.toDouble();
    return (totalReq > 0) ? (totalPaidMale / totalReq) * 100 : 0;
  }

  // Computed totals All Female Students

  int get totalRequiredFemale => posts
      .where((item) => item.gender == 'Female')
      .fold(0, (sum, item) => sum + item.required.toInt());

  int get totalPaidFemale => posts
      .where((item) => item.gender == 'Female')
      .fold(0, (sum, item) => sum + item.paid.toInt());

  int get totalRemainingFemale => posts
      .where((item) => item.gender == 'Female')
      .fold(0, (sum, item) => sum + (item.required - item.paid).toInt());

  double get totalPaidPercentageFemale {
    double totalReq = totalRequiredFemale.toDouble();
    return (totalReq > 0) ? (totalPaidFemale / totalReq) * 100 : 0;
  }

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
    fetchAllStudents(); // <-- Important to populate `posts`
  }

  // Fetch student statistics like total/active/inactive students etc.
  Future<void> fetchStatistics() async {
    try {
      isLoading(true);
      var data = await studentReportRepositories.getStatistics();
      if (data != null) {
        report.value = data;
        print('Fetched Report Data: ${data.toString()}');
      }
    } catch (e) {
      Get.snackbar("Error", 'Failed to fetch statistics: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllStudents() async {
    try {
      isLoading(true);
      final data = await _studentRepository.fetchStudents();
      print("Fetched students: $data"); // Debug line
      posts.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", 'Fetch failed: $e');
    } finally {
      isLoading(false);
    }
  }
}
