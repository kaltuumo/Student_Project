import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/repositories/student_repositories.dart';

class AttendanceController extends GetxController {
  var classLevels =
      [
        'Form One',
        'Form Two',
        'Form Three',
        'Form Four',
        '8th Grade',
        '7th Grade',
        '6th Grade',
        '5th Grade',
        '4th Grade',
        '3rd Grade',
        '2nd Grade',
        '1st Grade',
      ].obs;

  var selectedClassLevel = ''.obs; // Track selected class level
  var studentsInClass = <String>[].obs; // List of full names of students

  final StudentRepositories _studentRepository = StudentRepositories();

  Future<void> fetchStudentsInClass() async {
    try {
      final data =
          await _studentRepository.fetchStudents(); // Fetch all students
      if (selectedClassLevel.value.isNotEmpty) {
        List<StudentModel> filteredStudents =
            data.where((student) {
              return student.classLevel == selectedClassLevel.value;
            }).toList();

        // Combine fullname and phone into one string
        studentsInClass.value =
            filteredStudents
                .map(
                  (student) => '${student.fullname} - ${student.phone}',
                ) // Concatenate fullname and phone
                .toList();
      } else {
        studentsInClass.value =
            data
                .map(
                  (student) => '${student.fullname} - ${student.phone}',
                ) // Concatenate fullname and phone
                .toList();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        'Fetch failed: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
