import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:student_project/features/auth/screens/admin/login_admin.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/utils/constant/api_constant.dart';

class ApiClient {
  // Method to format date
  static String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  // Tusaale isticmaalkiisa:
  static void exampleUsage() {
    String formattedCreatedAt = formatDate("2025-06-12T16:13:19.923Z");
    String formattedUpdatedAt = formatDate("2025-06-12T16:14:18.577Z");

    print('Formatted CreatedAt: $formattedCreatedAt');
    print('Formatted UpdatedAt: $formattedUpdatedAt');
  }

  // ... (rest of your code remains unchanged)

  static Future<bool> signup({
    required String fullname,
    required String email,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConstants.adminEndpoint}/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        String token = responseBody['token']; // ✅ Correct field

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('email', email);

        Get.snackbar('Success', 'Account created successfully');
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['message'] ?? 'Signup failed';
        Get.snackbar('Error', errorMessage);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong during signup');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConstants.adminEndpoint}/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // Token ka soo qaad response-ka
        String token = responseBody['token'];

        // Kaydi token-ka si uu noqdo mid default ah
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('email', email);

        Get.snackbar('Success', 'Logged in successfully');
        return responseBody['user'];
      } else {
        final responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['message'] ?? 'User does not exist';
        Get.snackbar('Error', errorMessage);
        return null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
      return null;
    }
  }

  //Create Student

  static Future<bool> createStudent(StudentModel post) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Get.snackbar('Error', 'User not logged in');
      return false;
    }

    final url = Uri.parse('${ApiConstants.studentEndpoint}/create-student');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        String error = responseBody['message'] ?? 'Failed to create Student';
        Get.snackbar('Error', error);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
      return false;
    }
  }

  static Future<http.Response> getAdminProfile(String token) async {
    final url = Uri.parse(
      ApiConstants.profileAdminEndpoint,
    ); // Use the new endpoint

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Tirtir dhammaan xogta keydka
    Get.offAll(() => LoginAdmin());
  }
}
