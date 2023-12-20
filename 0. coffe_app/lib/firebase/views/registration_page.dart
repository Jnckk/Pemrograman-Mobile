// ignore_for_file: use_key_in_widget_constructors

import 'package:coffe_app/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController _controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _controller.email.value = value,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => _controller.password.value = value,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.register(),
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool loginSuccess = await _controller.login();
                    if (loginSuccess) {
                      Get.to(const FirebaseProfile());
                    } else {
                      Get.snackbar('Error', 'Email atau password salah.');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
