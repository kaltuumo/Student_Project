import 'package:get/get.dart';

import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/repositories/student_repositories.dart';

class PendingControllers extends GetxController {
  var isLoading = false.obs;
  var pendingStudents = [].obs;
  final RxList<StudentModel> posts = <StudentModel>[].obs;
  final StudentRepositories _postRepository = StudentRepositories();

  // Fetch pending students from the API
  // Fetch pending students from the API
  Future<void> fetchPending() async {
    try {
      isLoading(true);
      final data = await _postRepository.fetchStudents();
      print("Fetched students: $data"); // Debug line

      // Filter students with "Pending" status
      final pendingStudents =
          data.where((student) => student.status == 'Pending').toList();
      posts.assignAll(pendingStudents); // Assign filtered list to posts
    } catch (e) {
      Get.snackbar("Error", 'Fetch failed: $e');
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Fetch data when the controller is initialized
  @override
  void onInit() {
    super.onInit();
    fetchPending(); // Automatically fetch data when the controller is initialized
  }
}
