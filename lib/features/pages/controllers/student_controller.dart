import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/repositories/student_repositories.dart';

class StudentController extends GetxController {
  final fullnameController = TextEditingController();
  final genderController = TextEditingController();
  final requiredController = TextEditingController();
  final paidController = TextEditingController();
  final phoneController = TextEditingController();
  final RxString selectedGender = ''.obs; // ✅ Used by radio buttons

  final RxList<StudentModel> posts = <StudentModel>[].obs;
  final StudentRepositories _postRepository = StudentRepositories();

  final isLoading = false.obs;
  final isStudentCreated = false.obs;

  @override
  void onInit() {
    fetchAllStudents(); // Call once
    super.onInit();
  }

  Future<void> createStudent() async {
    if (fullnameController.text.isEmpty ||
        selectedGender.value.isEmpty ||
        (selectedGender.value != 'Male' && selectedGender.value != 'Female') ||
        requiredController.text.isEmpty ||
        paidController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Get.snackbar(
        'Foomka Khaldan',
        'Fadlan buuxi dhammaan meelaha, gaar ahaan dooro jinsiga (Male ama Female)',
      );
      return;
    }

    try {
      isLoading(true);

      final post = StudentModel(
        fullname: fullnameController.text.trim(),
        gender: selectedGender.value.trim(),
        required: int.parse(
          requiredController.text.trim(),
        ), // ✅ Convert string to int
        paid: int.parse(paidController.text.trim()), // ✅ Convert string to int
        phone: phoneController.text.trim(),
      );

      bool success = await _postRepository.createStudent(post);

      if (success) {
        fullnameController.clear();
        genderController.clear();
        requiredController.clear();
        paidController.clear();
        phoneController.clear();
        selectedGender.value = ''; //
        Get.snackbar('Success', 'Student created');
        isStudentCreated(true);
        await fetchAllStudents();
      } else {
        Get.snackbar('Error', 'Student creation failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  // Fetch all Students

  Future<void> fetchAllStudents() async {
    try {
      isLoading(true);
      final data = await _postRepository.fetchStudents();
      posts.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", 'Fetch failed: $e');
    } finally {
      isLoading(false);
    }
  }
}
