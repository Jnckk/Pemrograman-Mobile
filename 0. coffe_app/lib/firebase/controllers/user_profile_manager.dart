// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:coffe_app/controllers/controllers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileManager {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  Future<void> loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      nameController.text = user.displayName ?? '';
      genderController.text = await _loadGenderFromFirestore(user.uid);
    } else {
      nameController.text = '';
      genderController.text = '';
    }
  }

  Future<void> updateProfileData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateProfile(displayName: nameController.text);
        await _saveGenderToFirestore(user.uid, genderController.text);

        await loadProfileData();

        Get.snackbar('Sukses', 'Perubahan telah disimpan',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar(
            'Error', 'Tidak dapat mendapatkan informasi pengguna saat ini');
      }
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Error', 'Gagal memperbarui profil');
    }
  }

  Future<String> _loadGenderFromFirestore(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return snapshot.get('gender') ?? '';
      }
      return '';
    } catch (e) {
      print('Error loading gender: $e');
      return '';
    }
  }

  Future<void> _saveGenderToFirestore(String userId, String gender) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set({'gender': gender});
    } catch (e) {
      print('Error saving gender: $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    nameController.text = '';
    genderController.text = '';
  }

  void handleMasukDaftarClick(BuildContext context) {
    Get.to(() => RegistrationPage());
  }

  Widget buildProfileBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: controller.imagePath.isNotEmpty
                  ? FileImage(File(controller.imagePath.toString()))
                  : null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  final imagePicker =
                      ImagePicker(); // Create an instance of ImagePicker
                  controller
                      .getImage(imagePicker); // Pass the instance to the method
                },
                child: const Text('Pilih Foto'),
              ),
              TextButton(
                onPressed: () {
                  final imagePicker =
                      ImagePicker(); // Create an instance of ImagePicker
                  controller.getImages(
                      imagePicker); // Pass the instance to the method
                },
                child: const Text('Ambil Foto'),
              ),
            ],
          ),

          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: genderController,
            decoration: const InputDecoration(
              labelText: 'Jenis Kelamin',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: updateProfileData,
            child: const Text('Simpan Perubahan'),
          ),
        ],
      ),
    );
  }
}
