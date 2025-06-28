import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_project/features/pages/models/class_time_model.dart';
import 'package:student_project/features/pages/repositories/class_time_repositories.dart';

class ClassTimeController extends GetxController {
  final subjectController = TextEditingController();
  final teacherController = TextEditingController();
  final roomController = TextEditingController();
  final dayController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final RxList<ClassTimeModel> posts = <ClassTimeModel>[].obs;
  final ClassTimeRepositories classTimeRepositories = ClassTimeRepositories();
  final isLoading = false.obs;
  final RxString selectedDay = ''.obs; // ✅ Used by radio buttons

  final isClassCreated = false.obs;
  String? selectedPostId; // For update operations

  // String formatTime(String time24) {
  //   try {
  //     final time = DateFormat("HH:mm").parse(time24); // 24 saac
  //     return DateFormat("h:mm a").format(time); // 12 saac AM/PM
  //   } catch (e) {
  //     return time24; // fallback haddii ay dhibaato dhacdo
  //   }
  // }

  @override
  void onInit() {
    fetchAllClassTime(); // Call once
    super.onInit();
  }

  void setSelectedPostId(String id) {
    selectedPostId = id;
  }

  Future<void> createClassTime() async {
    if (subjectController.text.isEmpty ||
        teacherController.text.isEmpty ||
        roomController.text.isEmpty ||
        selectedDay.value.isEmpty ||
        (selectedDay.value != 'Saturday' &&
            selectedDay.value != 'Sunday' &&
            selectedDay.value != 'Monday' &&
            selectedDay.value != 'Tuesday' &&
            selectedDay.value != 'Wednesday') ||
        startTimeController.text.isEmpty ||
        endTimeController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'All Fields Are Required',

        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading(true);

      final post = ClassTimeModel(
        subject: subjectController.text.trim(),
        teacher: teacherController.text.trim(),
        room: roomController.text.trim(),
        day: selectedDay.value.trim(),
        startTime: startTimeController.text.trim(),
        endTime: endTimeController.text.trim(),
      );

      bool success = await classTimeRepositories.createClassTime(post);

      if (success) {
        subjectController.clear();
        teacherController.clear();
        roomController.clear();
        selectedDay.value = "";
        startTimeController.clear();
        endTimeController.clear();

        Get.snackbar(
          'Success',
          'Class created',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isClassCreated(true);
        await fetchAllClassTime();
      } else {
        Get.snackbar(
          'Error',
          'Class creation failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        'Error occurred: $e',
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllClassTime() async {
    try {
      isLoading(true);
      final data = await classTimeRepositories.fetchClassTime();
      print("Fetched Classes: $data"); // Debug line
      posts.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", 'Fetch failed: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateClassTime() async {
    if (selectedPostId == null) {
      Get.snackbar('Error', 'No post selected');
      return;
    }

    // Validate if any fields are empty
    if (subjectController.text.isEmpty) {
      Get.snackbar('Error', 'Subject is required');
      return;
    }

    // Check if gender is selected (validate the RxString selectedGender)
    if (selectedDay.value.isEmpty) {
      Get.snackbar('Error', 'Day is required');
      return;
    }

    if (teacherController.text.isEmpty) {
      Get.snackbar('Error', 'Teacher field is required');
      return;
    }

    if (roomController.text.isEmpty) {
      Get.snackbar('Error', 'Room field is required');
      return;
    }

    if (startTimeController.text.isEmpty) {
      Get.snackbar('Error', 'Start field is required');
      return;
    }
    if (endTimeController.text.isEmpty) {
      Get.snackbar('Error', 'End field is required');
      return;
    }
    try {
      isLoading(true);

      final post = ClassTimeModel(
        subject: subjectController.text.trim(),
        day: selectedDay.value.trim(),
        teacher: teacherController.text.trim(),
        room: roomController.text.trim(),
        startTime: startTimeController.text.trim(),
        endTime: endTimeController.text.trim(),
      );

      bool success = await classTimeRepositories.updateClassTime(
        selectedPostId!,
        post,
      );

      if (success) {
        subjectController.clear();
        teacherController.clear();
        roomController.clear();
        dayController.clear();
        startTimeController.clear();
        endTimeController.clear();
        selectedDay.value = ''; // Reset gender
        Get.snackbar(
          'Updated',
          'Class updated',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        isClassCreated(true);
        await fetchAllClassTime();
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

  Future<void> deleteClassTime() async {
    if (selectedPostId == null) {
      Get.snackbar('Error', 'No post selected');
      return;
    }

    try {
      isLoading(true);
      bool success = await classTimeRepositories.deleteClassTime(
        selectedPostId!,
      );

      if (success) {
        Get.snackbar(
          'Deleted',
          'Classes deleted',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        selectedPostId = null;
        await fetchAllClassTime();
      } else {
        Get.snackbar(
          'Error',
          'Class failed',
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
