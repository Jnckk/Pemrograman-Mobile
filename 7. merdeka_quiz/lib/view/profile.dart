// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merdeka_quiz/controller/controllers.dart';
import 'package:merdeka_quiz/view/startup.dart';

class Profile extends StatelessWidget {
  final AccountController accountController = AccountController();
  final UserDataController userDataController = Get.find<UserDataController>();
  final DatabaseController _databaseController = Get.find<DatabaseController>();

  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg/profilbg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
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
                    const SizedBox(height: 400),
                    Text('            Email     : ${userData[0]['Email']}',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    Text('            Nama    : ${userData[0]['Nama']}',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    Text('            Gender  : ${userData[0]['Gender']}',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                  ],
                );
              } else {
                return const Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 100),
                        SizedBox(height: 200),
                        Text(
                          'No user data available',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showAddOrUpdateDialog(
                        context, userDataController.userDataList.isNotEmpty);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF895B43),
                  ),
                  child: const Text('Edit Data'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteDialog(
                      context,
                      userDataController.userDataList.isNotEmpty
                          ? userDataController.userDataList[0]
                          : const {},
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF895B43),
                  ),
                  child: const Text('Hapus Data'),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const Startup());
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color(0xFF895B43),
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _showAddOrUpdateDialog(BuildContext context, bool dataExists) {
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
          backgroundColor: const Color(0xFFD4AF88),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal', style: TextStyle(color: Colors.black)),
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
              child:
                  const Text('Simpan', style: TextStyle(color: Colors.black)),
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
      await _refreshUserData(context);
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
      await _refreshUserData(context);
    } catch (error) {
      print('Kesalahan memperbarui data: $error');
    }

    Navigator.of(context).pop();
  }

  void _showDeleteDialog(
      BuildContext context, Map<String, dynamic> currentData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Anda yakin ingin menghapus data ini?'),
          backgroundColor: const Color(0xFFD4AF88),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                String userEmail = currentData['Email'];
                await userDataController.deleteUserData(userEmail);

                Navigator.of(context).pop();
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _refreshUserData(BuildContext context) async {
    try {
      String userEmail = userDataController.userDataList[0]['Email'];

      await userDataController.getUserData(userEmail);
    } catch (error) {
      print('Kesalahan menyegarkan data pengguna: $error');
    }
  }
}
