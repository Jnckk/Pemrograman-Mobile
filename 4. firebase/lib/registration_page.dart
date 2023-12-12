// registration_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registration_controller.dart';
import 'home_page.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController _controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _controller.email.value = value,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => _controller.password.value = value,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.register(),
                  child: Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Verifikasi login sebelum menavigasi ke home_page.dart
                    bool loginSuccess = await _controller.login();
                    if (loginSuccess) {
                      // Navigasi ke home_page.dart jika login berhasil
                      Get.to(HomePage());
                    } else {
                      // Tampilkan pesan error jika login gagal
                      Get.snackbar('Error', 'Email atau password salah.');
                    }
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
