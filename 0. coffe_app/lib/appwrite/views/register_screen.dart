import 'dart:math';
import 'package:coffe_app/appwrite/appwrite.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Coffee Shop Registration'),
        leading: const Icon(Icons.coffee),
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
                    decoration: const InputDecoration(
                      labelText: 'User ID',
                      prefixIcon: Icon(Icons.person),
                    ),
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
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 10),
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
                await accountController.createAccount({
                  'userId': userIdController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'name': nameController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC67C4E), // Coffee-related color
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
