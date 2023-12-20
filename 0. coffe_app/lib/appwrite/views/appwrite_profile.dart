// AppwriteProfile.dart
import 'package:coffe_app/appwrite/appwrite.dart';
import 'package:coffe_app/views/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppwriteProfile extends StatelessWidget {
  final AppwriteProfileController controller = AppwriteProfileController();

  AppwriteProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        leading: const Icon(Icons.coffee),
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
              // Add your help functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final userData = controller.userDataController.userDataList;

                if (userData.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Email\n ${userData[0]['Email']}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '\nNama\n ${userData[0]['Nama']}',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '\nGender\n ${userData[0]['Gender']}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                } else {
                  return const Text('No user data available');
                }
              }),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.showAddOrUpdateDialog(
                        context,
                        controller.userDataController.userDataList.isNotEmpty,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC67C4E),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.showDeleteDialog(
                        context,
                        controller.userDataController.userDataList.isNotEmpty
                            ? controller.userDataController.userDataList[0]
                            : const {},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC67C4E),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(() => DashboardView());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC67C4E),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.white),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
