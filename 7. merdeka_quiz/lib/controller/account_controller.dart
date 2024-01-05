// ignore_for_file: avoid_print, unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';
import 'package:merdeka_quiz/controller/controllers.dart';

class AccountController extends ClientController {
  Account? account;
  bool isLoggedIn = false;
  String? loggedInEmail;

  @override
  void onInit() {
    super.onInit();
    account = Account(client);
  }

  Future<void> createAccount(Map<String, dynamic> map) async {
    try {
      if (account != null) {
        if (map['name'] == null || map['name'].isEmpty) {
          Get.snackbar('Error', 'Nama tidak boleh kosong.');
          return;
        }

        if (map['email'] == null || map['email'].isEmpty) {
          Get.snackbar('Error', 'Email tidak boleh kosong.');
          return;
        }

        if (!isValidEmail(map['email'])) {
          Get.snackbar('Error', 'Format email tidak valid.');
          return;
        }

        if (map['password'] == null || map['password'].isEmpty) {
          Get.snackbar('Error', 'Password tidak boleh kosong.');
          return;
        }

        final result = await account!.create(
          userId: map['userId'],
          email: map['email'],
          password: map['password'],
          name: map['name'],
        );

        print("AccountController:: createAccount $result");
        Get.snackbar('Success', 'Akun berhasil dibuat.');
      } else {
        print('AccountController:: createAccount - Account not initialized');
      }
    } catch (error) {
      Get.snackbar(
          'Error', 'Terjadi kesalahan saat membuat akun. Silakan coba lagi.');
    }
  }

  bool isValidEmail(String email) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return regex.hasMatch(email);
  }

  Future<void> createEmailSession(Map<String, dynamic> map) async {
    try {
      if (account != null) {
        final result = await account!.createEmailSession(
          email: map['email'],
          password: map['password'],
        );
        isLoggedIn = (result != null);

        Get.snackbar('Berhasil', 'Login Berhasil');
        print("AccountController:: createEmailSession $result");
      } else {
        print(
            'AccountController:: createEmailSession - Account not initialized');
      }
    } catch (error) {
      isLoggedIn = false;
      Get.snackbar('Error', 'Email atau password salah.');
    }
  }
}
