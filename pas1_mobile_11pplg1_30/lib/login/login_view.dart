import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/reusable/textfield.dart';
import 'apilogin_controller.dart';

class LoginView extends StatelessWidget {
  final ApiloginControllerr apiloginControllerr =
      Get.put(ApiloginControllerr());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _buildLoginForm(context),
                SizedBox(height: 20),
                _buildStatusMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Login to Your Account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Welcome back! Please enter your credentials to continue.',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
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
          SizedBox(height: 32),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              if (usernameController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                apiloginControllerr.loginStatus.value = 'All fields are required';
              } else {
                apiloginControllerr.loginUser(
                  usernameController.text,
                  passwordController.text,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadowColor: Colors.deepPurple.withOpacity(0.5),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 55,
          child: OutlinedButton(
            onPressed: () {
              // Get.to(() => RegisterView());
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.deepPurple, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              foregroundColor: Colors.deepPurple,
            ),
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusMessage() {
    return Obx(
      () => Column(
        children: [
          Text(
            apiloginControllerr.loginStatus.value,
            style: TextStyle(
              color: apiloginControllerr.loginStatus.value.contains('berhasil')
                  ? Colors.green
                  : Colors.red,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          if (apiloginControllerr.token.value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Token: ${apiloginControllerr.token.value}',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
