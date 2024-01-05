import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merdeka_quiz/controller/controllers.dart';
import 'package:merdeka_quiz/view/views.dart';

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
      appBar: null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/bg/regbg.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await accountController.createAccount({
                      'userId': userIdController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'name': nameController.text,
                    });
                    Get.to(() => const Startup());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff895b43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
