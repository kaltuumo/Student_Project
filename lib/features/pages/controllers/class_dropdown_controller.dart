import 'package:get/get.dart';

class ClassDropdownController extends GetxController {
  var classStudentList =
      ['Secondary Morning', 'Primary Morning', 'Primary AfterNoon'].obs;

  var selectedClassStudent = ''.obs;
  var classLevels = <String>[].obs;
  var selectedClassLevel = ''.obs;

  void updateClassStudent(String value) {
    selectedClassStudent.value = value;
    selectedClassLevel.value = ''; // reset selection
    if (value == 'Secondary Morning') {
      classLevels.value = ['Form One', 'Form Two', 'Form Three', 'Form Four'];
    } else if (value == 'Primary Morning') {
      classLevels.value = ['8th Grade', '7th Grade', '6th Grade', '5th Grade'];
    } else if (value == 'Primary AfterNoon') {
      classLevels.value = ['4th Grade', '3rd Grade', '2nd Grade', '1st Grade'];
    }
  }

  void updateClassLevel(String value) {
    selectedClassLevel.value = value;
  }
}
