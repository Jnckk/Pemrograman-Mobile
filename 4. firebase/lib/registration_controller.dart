// controller.dart
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxString email = ''.obs;
  RxString password = ''.obs;

  Future<void> register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Registrasi berhasil
      print('Registrasi berhasil: ${userCredential.user?.email}');

      // Tampilkan notifikasi registrasi berhasil
      Get.snackbar('Sukses', 'Registrasi berhasil');
    } catch (e) {
      // Handle error
      print('Error saat registrasi: $e');
      // Tampilkan notifikasi error
      Get.snackbar('Error', 'Gagal registrasi');
    }
  }

  Future<bool> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // Login berhasil
      print('Login berhasil: ${userCredential.user?.email}');

      // Tampilkan notifikasi login berhasil
      Get.snackbar('Sukses', 'Login berhasil');

      return true;
    } catch (e) {
      // Handle error
      print('Error saat login: $e');
      return false;
    }
  }
}
