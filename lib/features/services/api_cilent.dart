import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:student_project/features/auth/screens/admin/login_admin.dart';
import 'package:student_project/features/pages/models/attendence_model.dart';
import 'package:student_project/features/pages/models/class_time_model.dart';
import 'package:student_project/features/pages/models/student_model.dart';
import 'package:student_project/features/pages/models/student_report_model.dart';
import 'package:student_project/utils/constant/api_constant.dart';

class ApiClient {
  static String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(dateTime);
  }

  static void exampleUsage() {
    String formattedCreatedAt = formatDate("2025-06-12T16:13:19.923Z");
    String formattedUpdatedAt = formatDate("2025-06-12T16:14:18.577Z");

    print('Formatted CreatedAt: $formattedCreatedAt'); // 12 June 2025
    print('Formatted UpdatedAt: $formattedUpdatedAt'); // 12 June 2025
  }

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

      if (response.statusCode == 200 || response.statusCode == 201) {
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

  static Future<bool> createClassTime(ClassTimeModel post) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Get.snackbar('Error', 'User not logged in');
      return false;
    }

    final url = Uri.parse('${ApiConstants.classEndpoint}/create-classtime');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        String error = responseBody['message'] ?? 'Failed to create Class';
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

  // GET ALL STUDENTS

  static Future<List<dynamic>> getStudents() async {
    final url = Uri.parse('${ApiConstants.studentEndpoint}/all-students');

    try {
      final response = await http.get(url);
      print("Response status: ${response.statusCode}"); // Log status
      print("Response body: ${response.body}"); // Log the body

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        List students = jsonBody['data'];
        print("RESPONSE DATA: $jsonBody");

        return students;
      } else {
        throw Exception('Failed to load Students');
      }
    } catch (e) {
      throw Exception('Failed to load Students: $e');
    }
  }

  // GET ALL CLASSTIME

  static Future<List<dynamic>> getClassTime() async {
    final url = Uri.parse('${ApiConstants.classEndpoint}/all-classtime');

    try {
      final response = await http.get(url);
      print("Response status: ${response.statusCode}"); // Log status
      print("Response body: ${response.body}"); // Log the body

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        List students = jsonBody['data'];
        print("RESPONSE DATA: $jsonBody");

        return students;
      } else {
        throw Exception('Failed to load Students');
      }
    } catch (e) {
      throw Exception('Failed to load Students: $e');
    }
  }

  static Future<List<dynamic>> getPending() async {
    final url = Uri.parse('${ApiConstants.studentEndpoint}/get-pending');

    try {
      final response = await http.get(url);
      print("Response status: ${response.statusCode}"); // Log status
      print("Response body: ${response.body}"); // Log the body

      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(response.body);

        List students = jsonBody['data'];
        print("RESPONSE DATA: $jsonBody");

        return students;
      } else {
        throw Exception('Failed to load Students');
      }
    } catch (e) {
      throw Exception('Failed to load Students: $e');
    }
  }

  static Future<http.Response> getAllStudents(String token) async {
    final url = Uri.parse('${ApiConstants.studentEndpoint}/all-students');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  static Future<bool> updateStudent(String id, StudentModel student) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Get.snackbar('Error', 'User not logged in');
      return false;
    }

    final url = Uri.parse('${ApiConstants.studentEndpoint}/update-student/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(student.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        String error = responseBody['message'] ?? 'Failed to update post';
        Get.snackbar('Error', error);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      return false;
    }
  }

  static Future<bool> updateClassTime(String id, ClassTimeModel classes) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Get.snackbar('Error', 'User not logged in');
      return false;
    }

    final url = Uri.parse('${ApiConstants.classEndpoint}/update-classtime/$id');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(classes.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final responseBody = jsonDecode(response.body);
        String error = responseBody['message'] ?? 'Failed to update Class';
        Get.snackbar('Error', error);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      return false;
    }
  }
  // DELETE STUDENT

  static Future<bool> deletePost(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Sending token: $token');

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'No token found');
      return false;
    }

    final url = Uri.parse(
      '${ApiConstants.studentEndpoint}/delete-student/$id',
    ); // Correct URL with query string

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Ensure token is being sent in the header
        },
      );

      if (response.statusCode == 200) {
        print('Post deleted successfully');
        return true;
      } else {
        print('Failed to delete post: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting post: $e');
      return false;
    }
  }

  static Future<bool> deleteClassTime(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('Sending token: $token');

    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'No token found');
      return false;
    }

    final url = Uri.parse(
      '${ApiConstants.classEndpoint}/delete-classtime/$id',
    ); // Correct URL with query string

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Ensure token is being sent in the header
        },
      );

      if (response.statusCode == 200) {
        print('Class deleted successfully');
        return true;
      } else {
        print('Failed to delete Class: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting post: $e');
      return false;
    }
  }

  static Future<bool> markAttendance(AttendanceModel attendance) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      Get.snackbar('Error', 'User not logged in');
      return false;
    }

    final url = Uri.parse('${ApiConstants.attendanceEndpoint}/mark');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(attendance.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      print('Error: ${response.statusCode}, Response: ${response.body}');
      return false;
    }
  }

  // Statistics Student
  static Future<StudentReportModel?> getStudentStatistics() async {
    final url = Uri.parse('${ApiConstants.studentEndpoint}/statistics');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return StudentReportModel.fromJson(body['data']);
      } else {
        throw Exception('Failed to load statistics');
      }
    } catch (e) {
      print("Error:, $e");
      return null;
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Tirtir dhammaan xogta keydka
    Get.offAll(() => LoginAdmin());
  }
}
