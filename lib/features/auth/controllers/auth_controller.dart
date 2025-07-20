import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_project/features/pages/screens/dashboard/dashboard.dart';
import 'package:student_project/features/services/api_cilent.dart';

class AuthController extends GetxController {
  final currentUserId = ''.obs; // Si aad ugu kaydiso user ID login kadib
  var selectedGender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStoredUserId(); // markuu app-ku furmo
  }

  void _loadStoredUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId != null && userId.isNotEmpty) {
      currentUserId.value = userId;
    }
  }

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var fullname = ''.obs; // Add this to hold the fullname
  var email = ''.obs; // Add this to hold the email

  var isLoading = false.obs;

  void clearSignupFields() {
    fullnameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
  }

  Future<bool> signupAdmin() async {
    if (fullnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return false;
    }

    isLoading(true);
    bool result = await ApiClient.signup(
      fullname: fullnameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );
    isLoading(false);

    return result;
  }

  Future<void> loginAdmin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    isLoading(true);

    try {
      final userData = await ApiClient.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userData != null && userData['id'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userData['id']);
        print('User ID saved to SharedPreferences: ${userData['id']}');
        fullname.value = userData['fullname'];
        await prefs.setString('fullname', userData['fullname']);
        email.value = userData['email'];
        await prefs.setString('email', userData['email']);

        // Set the user ID in the controller
        currentUserId.value = userData['id'];
        fullname.value = userData['fullname'];
        email.value = userData['email'];

        // Get.offAll(() => Dashboard());
      } else {
        Get.snackbar('Error', 'Invalid login response');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed');
      print("Login error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userEmail = prefs.getString('email');

    if (token != null && userEmail != null) {
      try {
        final response = await ApiClient.getAdminProfile(token);
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          final users = responseData['data'] as List;

          final currentUser = users.firstWhere(
            (user) => user['email'] == userEmail,
            orElse: () => null,
          );

          if (currentUser != null) {
            fullname.value = currentUser['fullname'] ?? 'Unknown';
            email.value =
                currentUser['email'] ??
                'unknown@example.com'; // ✅ email sidoo kale
          } else {
            Get.snackbar('Error', 'User not found');
          }
        } else {
          Get.snackbar('Error', 'Failed to load user data');
        }
      } catch (e) {
        Get.snackbar('Error', 'Error: $e');
      }
    } else {
      Get.snackbar('Error', 'Login data missing. Please login again.');
    }
  }

  Future<void> logoutAdmin() async {
    await ApiClient.logout();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    currentUserId.value = '';
    fullname.value = ''; // ✅
  }
}
