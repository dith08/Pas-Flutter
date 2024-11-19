import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/reusable/textfield.dart';
import 'register_controller.dart';


class RegisterView extends StatelessWidget {
  final RegisterController postControllerr = Get.put(RegisterController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 1,
      ),
      body: Container(
        color: Colors.grey.shade100, // Background plain color
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Create Your Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: usernameController,
                        labelText: 'Username',
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        isPassword: true,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: fullNameController,
                        labelText: 'Full Name',
                        prefixIcon: Icons.badge,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        controller: emailController,
                        labelText: 'Email',
                        prefixIcon: Icons.email,
                      ),
                      SizedBox(height: 24),
                      _buildRegisterButton(),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                _buildStatusMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (usernameController.text.isEmpty ||
              passwordController.text.isEmpty ||
              fullNameController.text.isEmpty ||
              emailController.text.isEmpty) {
            postControllerr.registerStatus.value = 'All fields are required';
          } else {
            postControllerr.registerUser(
              usernameController.text,
              passwordController.text,
              fullNameController.text,
              emailController.text,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.blue.shade600,
          elevation: 4,
        ),
        child: Text(
          'Register',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusMessage() {
    return Obx(() => Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: postControllerr.registerStatus.value.contains('success')
                  ? Colors.green.shade400
                  : Colors.red.shade400,
            ),
          ),
          child: Text(
            postControllerr.registerStatus.value,
            style: TextStyle(
              color: postControllerr.registerStatus.value.contains('success')
                  ? Colors.green.shade600
                  : Colors.red.shade600,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
