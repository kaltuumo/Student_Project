import 'package:flutter/material.dart';
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
  final classStudentController = TextEditingController();
  final classLevelController = TextEditingController();

  final RxString selectedGender = ''.obs;
  final RxString selectedEducation = ''.obs;

  final RxString selectedClassStudent = ''.obs;
  final RxString selectedClassLevel = ''.obs;

  final RxList<StudentModel> posts = <StudentModel>[].obs;
  final StudentRepositories _studentRepository = StudentRepositories();

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
        phoneController.text.isEmpty ||
        selectedClassStudent.value.isEmpty ||
        selectedClassLevel.value.isEmpty) {
      Get.snackbar(
        'Foomka Khaldan',
        'Fadlan buuxi dhammaan meelaha, gaar ahaan dooro jinsiga (Male ama Female), class iyo class level',
        backgroundColor: Colors.red,
        colorText: Colors.white,
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
        classStudent: selectedClassStudent.value.trim(),
        classLevel: selectedClassLevel.value.trim(),
      );

      bool success = await _studentRepository.createStudent(post);

      if (success) {
        fullnameController.clear();
        genderController.clear();
        educationController.clear();
        requiredController.clear();
        paidController.clear();
        phoneController.clear();
        selectedGender.value = ''; //
        selectedEducation.value = ''; // Reset selected education
        selectedClassStudent.value = '';
        selectedClassLevel.value = '';
        Get.snackbar(
          'Success',
          'Student created',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isStudentCreated(true);
        await fetchAllStudents();
      } else {
        Get.snackbar(
          'Error',
          'Student creation failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error occurred: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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
      bool success = await _studentRepository.deleteStudent(selectedPostId!);

      if (success) {
        Get.snackbar(
          'Deleted',
          'Student deleted',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        selectedPostId = null;
        await fetchAllStudents();
      } else {
        Get.snackbar(
          'Error',
          'Delete failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
      final data = await _studentRepository.fetchStudents();
      print("Fetched students:, $data"); // Debug line
      posts.assignAll(data);
    } catch (e) {
      Get.snackbar(
        "Error",
        'Fetch failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateStudent() async {
    if (selectedPostId == null) {
      Get.snackbar('Error', 'No post selected');
      return;
    }

    // Validate if any fields are empty
    if (fullnameController.text.isEmpty) {
      Get.snackbar('Error', 'Full Name is required');
      return;
    }

    // Check if gender is selected (validate the RxString selectedGender)
    if (selectedGender.value.isEmpty) {
      Get.snackbar('Error', 'Gender is required');
      return;
    }

    if (selectedEducation.value.isEmpty) {
      Get.snackbar('Error', 'Education is required');
      return;
    }

    if (requiredController.text.isEmpty) {
      Get.snackbar('Error', 'Required field is required');
      return;
    }

    if (paidController.text.isEmpty) {
      Get.snackbar('Error', 'Paid field is required');
      return;
    }

    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Phone field is required');
      return;
    }

    if (selectedClassStudent.value.isEmpty) {
      Get.snackbar('Error', 'ClassStudent is required');
      return;
    }
    if (selectedClassLevel.value.isEmpty) {
      Get.snackbar('Error', 'ClassLevel is required');
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
        classStudent: selectedClassStudent.value.trim(),
        classLevel: selectedClassLevel.value.trim(),
      );

      bool success = await _studentRepository.updateStudent(
        selectedPostId!,
        post,
      );

      if (success) {
        fullnameController.clear();
        genderController.clear();
        educationController.clear();
        requiredController.clear();
        paidController.clear();
        phoneController.clear();
        selectedGender.value = ''; // Reset gender
        selectedEducation.value = ''; // Reset education
        selectedClassStudent.value = '';
        selectedClassLevel.value = '';
        Get.snackbar(
          'Updated',
          'Student updated',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isStudentCreated(true);
        await fetchAllStudents();
      } else {
        Get.snackbar(
          'Error',
          'Update failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
