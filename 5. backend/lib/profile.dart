// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:backend/account_controller.dart';
import 'package:backend/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_data_controller.dart';

class Profile extends StatelessWidget {
  final AccountController accountController = AccountController();
  final UserDataController userDataController = Get.find<UserDataController>();
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final userData = userDataController.userDataList;

              if (userData.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${userData[0]['Email']}'),
                    Text('Nama: ${userData[0]['Nama']}'),
                    Text('Gender: ${userData[0]['Gender']}'),
                    const SizedBox(height: 16),
                  ],
                );
              } else {
                return const Text('No user data available');
              }
            }
          ),
            ElevatedButton(
              onPressed: () {
                _showAddOrUpdateDialog(
                    context, userDataController.userDataList.isNotEmpty);
              },
              child: const Text('Tambah/Ubah Data'),
            ),
            ElevatedButton(
              onPressed: () {
                _showDeleteDialog(
                  context,
                  userDataController.userDataList.isNotEmpty
                      ? userDataController.userDataList[0]
                      : const {}, // Provide a default non-null value
                );
              },
              child: const Text('Hapus Data'),
            ),

            ElevatedButton(
              onPressed: () {
                Get.back(); // Go back to the previous screen (LoginScreen)
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

 void _showAddOrUpdateDialog(BuildContext context, bool dataExists) {
    TextEditingController emailController = TextEditingController();
    TextEditingController namaController = TextEditingController();
    TextEditingController genderController = TextEditingController();

    if (dataExists) {
      // If data exists, pre-fill the form fields
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
                // Validate form fields if needed

                // Save data
                if (dataExists) {
                  // Update existing data
                  _updateData(context, {
                    'Email': emailController.text,
                    'Nama': namaController.text,
                    'Gender': genderController.text,
                  });
                } else {
                  // Add new data
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
      // Konversi nilai dinamis ke String secara eksplisit
      Map<String, String> newDataStringMap =
          newData.map((key, value) => MapEntry(key, value.toString()));

      await _databaseController.createDocument(newDataStringMap);
      print('Data berhasil ditambahkan: $newDataStringMap');

      // Ambil ulang dan segarkan data pengguna setelah menambahkan data baru
      await _refreshUserData(context);
    } catch (error) {
      print('Kesalahan menambahkan data: $error');
    }

    Navigator.of(context).pop(); // Tutup dialog
  }

  void _updateData(
      BuildContext context, Map<String, dynamic> updatedData) async {
    try {
      // Konversi nilai dinamis ke String secara eksplisit
      Map<String, String> updatedDataStringMap =
          updatedData.map((key, value) => MapEntry(key, value.toString()));

      // Ekstrak ID dokumen dari daftar data pengguna yang diperbarui
      String documentId = userDataController.userDataList[0]['\$id'];

      await _databaseController.updateDocument(
          documentId, updatedDataStringMap);
      print('Data berhasil diperbarui: $updatedDataStringMap');

      // Ambil ulang dan segarkan data pengguna setelah memperbarui data
      await _refreshUserData(context);
    } catch (error) {
      print('Kesalahan memperbarui data: $error');
    }

    Navigator.of(context).pop(); // Tutup dialog
  }

  void _showDeleteDialog(
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
                // Get the user email from the current data
                String userEmail = currentData['Email'];

                // Delete user data from the database
                await userDataController.deleteUserData(userEmail);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // Metode bantuan untuk menyegarkan data pengguna dan memperbarui antarmuka pengguna
  Future<void> _refreshUserData(BuildContext context) async {
    try {
      // Dapatkan email pengguna dari data pengguna yang diperbarui
      String userEmail = userDataController.userDataList[0]['Email'];

      // Ambil data pengguna yang diperbarui dari database
      await userDataController.getUserData(userEmail);
    } catch (error) {
      print('Kesalahan menyegarkan data pengguna: $error');
    }
  }
}
