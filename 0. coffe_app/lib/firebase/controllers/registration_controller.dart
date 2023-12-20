// ignore_for_file: avoid_print

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
      print('Registrasi berhasil: ${userCredential.user?.email}');
      Get.snackbar('Sukses', 'Registrasi berhasil');
    } catch (e) {
      print('Error saat registrasi: $e');
      Get.snackbar('Error', 'Gagal registrasi');
    }
  }

  Future<bool> login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      print('Login berhasil: ${userCredential.user?.email}');
      Get.snackbar('Sukses', 'Login berhasil');

      return true;
    } catch (e) {
      print('Error saat login: $e');
      return false;
    }
  }
}
