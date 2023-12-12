// ignore_for_file: avoid_print

import 'package:backend/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'account_controller.dart';
import 'profile.dart'; // Import the Profile class
import 'user_data_controller.dart';

class LoginScreen extends StatelessWidget {
  final AccountController accountController = AccountController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    accountController.onInit();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await accountController.createEmailSession({
                    'email': emailController.text,
                    'password': passwordController.text,
                  });

                  if (accountController.isLoggedIn) {
                    UserDataController userDataController =
                        Get.find<UserDataController>();
                    await userDataController.getUserData(emailController.text);

                    // Navigate to the Profile class, passing user data as an argument
                    Get.to(() => Profile(),
                        arguments: userDataController.userDataList);
                  } else {
                    print('Login failed');
                  }
                } catch (error) {
                  print('Error during login: $error');
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
