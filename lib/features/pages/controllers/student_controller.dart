import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/repositories/student_repositories.dart';

class StudentController extends GetxController {
  final fullnameController = TextEditingController();
  final genderController = TextEditingController();
  final educationController = TextEditingController();
  final requiredController = TextEditingController();
  final paidController = TextEditingController();
  final phoneController = TextEditingController();
  final RxString selectedGender = ''.obs; // ✅ Used by radio buttons
  final RxString selectedEducation = ''.obs; // ✅ Used by radio buttons

  final RxList<StudentModel> posts = <StudentModel>[].obs;
  final StudentRepositories _postRepository = StudentRepositories();

  final isLoading = false.obs;
  final isStudentCreated = false.obs;
  String? selectedPostId; // For update operations

  @override
  void onInit() {
    fetchAllStudents(); // Call once
    super.onInit();
  }

  void setSelectedPostId(String id) {
    selectedPostId = id;
  }

  Future<void> createStudent() async {
    if (fullnameController.text.isEmpty ||
        selectedGender.value.isEmpty ||
        (selectedGender.value != 'Male' && selectedGender.value != 'Female') ||
        selectedEducation.value.isEmpty ||
        (selectedEducation.value != 'Primary' &&
            selectedEducation.value != 'Secondary') ||
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
      // Convert required and paid to double
      double requiredAmount = double.parse(requiredController.text.trim());
      double paidAmount = double.parse(paidController.text.trim());
      final post = StudentModel(
        fullname: fullnameController.text.trim(),
        gender: selectedGender.value.trim(),
        education: selectedEducation.value.trim(),
        required: requiredAmount, // ✅ Convert string to double
        paid: paidAmount,
        phone: phoneController.text.trim(),
      );

      bool success = await _postRepository.createStudent(post);

      if (success) {
        fullnameController.clear();
        genderController.clear();
        educationController.clear();
        requiredController.clear();
        paidController.clear();
        phoneController.clear();
        selectedGender.value = ''; //
        selectedEducation.value = ''; // Reset selected education
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

  Future<void> deleteStudent() async {
    if (selectedPostId == null) {
      Get.snackbar('Error', 'No post selected');
      return;
    }

    try {
      isLoading(true);
      bool success = await _postRepository.deleteStudent(selectedPostId!);

      if (success) {
        Get.snackbar('Deleted', 'Student deleted');
        selectedPostId = null;
        await fetchAllStudents();
      } else {
        Get.snackbar('Error', 'Delete failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Fetch all Students

  Future<void> fetchAllStudents() async {
    try {
      isLoading(true);
      final data = await _postRepository.fetchStudents();
      print("Fetched students: $data"); // Debug line
      posts.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", 'Fetch failed: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateStudent() async {
    if (selectedPostId == null) {
      Get.snackbar('Error', 'No post selected');
      return;
    }

    if (fullnameController.text.isEmpty ||
        genderController.text.isEmpty ||
        educationController.text.isEmpty ||
        requiredController.text.isEmpty ||
        paidController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Title and Description required');
      return;
    }

    try {
      isLoading(true);
      double requiredAmount = double.parse(requiredController.text.trim());
      double paidAmount = double.parse(paidController.text.trim());

      final post = StudentModel(
        fullname: fullnameController.text.trim(),
        gender: selectedGender.value.trim(),
        education: selectedEducation.value.trim(),
        required: requiredAmount,
        paid: paidAmount,
        phone: phoneController.text.trim(),
      );

      bool success = await _postRepository.updateStudent(selectedPostId!, post);

      if (success) {
        fullnameController.clear();
        genderController.clear();
        educationController.clear();
        requiredController.clear();
        paidController.clear();
        phoneController.clear();
        selectedGender.value = ''; //
        selectedEducation.value = ''; // Reset selected education
        Get.snackbar('Updated', 'Student updated');
        isStudentCreated(true);
        await fetchAllStudents();
      } else {
        Get.snackbar('Error', 'Update failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
