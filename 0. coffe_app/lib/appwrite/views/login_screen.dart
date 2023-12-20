// ignore_for_file: avoid_print

import 'package:coffe_app/appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        title: const Text('Coffee Shop Login'),
        leading: const Icon(Icons.coffee),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
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
                    Get.to(() => AppwriteProfile(),
                        arguments: userDataController.userDataList);
                  } else {
                    print('Login failed');
                  }
                } catch (error) {
                  print('Error during login: $error');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC67C4E),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 12),
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
