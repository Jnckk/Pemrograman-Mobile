import 'dart:math';
import 'package:flutter/material.dart';
import 'package:backend/account_controller.dart';
import 'package:backend/client_controller.dart';

class RegisterScreen extends StatelessWidget {
  final ClientController clientController = ClientController();
  final AccountController accountController = AccountController();

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  String generateRandomUserId() {
    return 'Account${Random().nextInt(10000)}';
  }

  @override
  Widget build(BuildContext context) {
    clientController.onInit();
    accountController.onInit();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: userIdController,
                    decoration: const InputDecoration(labelText: 'User ID'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    userIdController.text = generateRandomUserId();
                  },
                ),
              ],
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
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
                await accountController.createAccount({
                  'userId': userIdController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'name': nameController.text,
                });
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
