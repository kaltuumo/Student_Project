import 'package:student_project/features/pages/models/class_time_model.dart';
import 'package:student_project/features/services/api_cilent.dart';

class ClassTimeRepositories {
  Future<bool> createClassTime(ClassTimeModel post) {
    return ApiClient.createClassTime(post);
  }

  Future<List<ClassTimeModel>> fetchClassTime() async {
    final postsData = await ApiClient.getClassTime(); // API call
    print("✅ JSON DATA: $postsData"); // Ku dar tan si aad u hubiso xogta

    return postsData
        .map<ClassTimeModel>((json) => ClassTimeModel.fromJson(json))
        .toList();
  }

  Future<bool> updateClassTime(String id, ClassTimeModel classes) {
    return ApiClient.updateClassTime(id, classes);
  }

  Future<bool> deleteClassTime(String id) {
    return ApiClient.deleteClassTime(id);
  }
}
