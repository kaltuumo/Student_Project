import 'package:get/get.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/services/api_cilent.dart';

class PendingRepositories extends GetxController {
  Future<List<StudentModel>> fetchPending() async {
    final postsData = await ApiClient.getPending(); // API call
    print("✅ JSON DATA: $postsData"); // Ku dar tan si aad u hubiso xogta

    return postsData
        .map<StudentModel>((json) => StudentModel.fromJson(json))
        .toList();
  }
}
