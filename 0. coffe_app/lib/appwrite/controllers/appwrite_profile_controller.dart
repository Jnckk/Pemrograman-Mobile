// AppwriteProfileController.dart
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:coffe_app/appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppwriteProfileController extends GetxController {
  final AccountController accountController = AccountController();
  final UserDataController userDataController = Get.find<UserDataController>();
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  late TextEditingController emailController;
  late TextEditingController namaController;
  late TextEditingController genderController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    namaController = TextEditingController();
    genderController = TextEditingController();
  }

  void showAddOrUpdateDialog(BuildContext context, bool dataExists) {
    TextEditingController emailController = TextEditingController();
    TextEditingController namaController = TextEditingController();
    TextEditingController genderController = TextEditingController();

    if (dataExists) {
      emailController.text = userDataController.userDataList[0]['Email'];
      namaController.text = userDataController.userDataList[0]['Nama'];
      genderController.text = userDataController.userDataList[0]['Gender'];
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dataExists ? 'Ubah Data' : 'Tambah Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextFormField(
                controller: genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                if (dataExists) {
                  _updateData(context, {
                    'Email': emailController.text,
                    'Nama': namaController.text,
                    'Gender': genderController.text,
                  });
                } else {
                  _addData(context, {
                    'Email': emailController.text,
                    'Nama': namaController.text,
                    'Gender': genderController.text,
                  });
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _addData(BuildContext context, Map<String, dynamic> newData) async {
    try {
      Map<String, String> newDataStringMap =
          newData.map((key, value) => MapEntry(key, value.toString()));

      await _databaseController.createDocument(newDataStringMap);
      print('Data berhasil ditambahkan: $newDataStringMap');

      await refreshUserData(context);
    } catch (error) {
      print('Kesalahan menambahkan data: $error');
    }

    Navigator.of(context).pop();
  }

  void _updateData(
      BuildContext context, Map<String, dynamic> updatedData) async {
    try {
      Map<String, String> updatedDataStringMap =
          updatedData.map((key, value) => MapEntry(key, value.toString()));

      String documentId = userDataController.userDataList[0]['\$id'];

      await _databaseController.updateDocument(
          documentId, updatedDataStringMap);
      print('Data berhasil diperbarui: $updatedDataStringMap');

      await refreshUserData(context);
    } catch (error) {
      print('Kesalahan memperbarui data: $error');
    }

    Navigator.of(context).pop();
  }

  void showDeleteDialog(
      BuildContext context, Map<String, dynamic> currentData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                String userEmail = currentData['Email'];

                await userDataController.deleteUserData(userEmail);

                Navigator.of(context).pop();
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Future<void> refreshUserData(BuildContext context) async {
    try {
      String userEmail = userDataController.userDataList[0]['Email'];

      await userDataController.getUserData(userEmail);
    } catch (error) {
      print('Kesalahan menyegarkan data pengguna: $error');
    }
  }
}
