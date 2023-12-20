// ignore_for_file: library_private_types_in_public_api

import 'package:coffe_app/firebase/firebase.dart';
import 'package:coffe_app/views/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseProfile extends StatefulWidget {
  const FirebaseProfile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<FirebaseProfile> {
  final UserProfileManager userProfileManager = UserProfileManager();

  @override
  void initState() {
    super.initState();
    userProfileManager.loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => DashboardView());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () {
              Get.to(() => const WebviewPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
            },
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: "masukDaftar",
                  child: Text("Masuk / Daftar"),
                ),
                const PopupMenuItem(
                  value: "logout",
                  child: Text("Logout"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == "masukDaftar") {
                userProfileManager.handleMasukDaftarClick(context);
              } else if (value == "logout") {
                userProfileManager.logout();
              }
            },
          ),
        ],
      ),
      body: userProfileManager.buildProfileBody(),
    );
  }
}
