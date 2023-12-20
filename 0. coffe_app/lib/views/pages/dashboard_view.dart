// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:coffe_app/controllers/controllers.dart';
import 'package:coffe_app/views/components/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  ImagePickerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        automaticallyImplyLeading: false,
        actions: [
          Obx(() {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: controller.imagePath.isNotEmpty
                      ? FileImage(File(controller.imagePath.toString()))
                      : null,
                ),
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MenuGridView(),
          ),
          const MenuBottomNavigation(),
        ],
      ),
    );
  }
}
