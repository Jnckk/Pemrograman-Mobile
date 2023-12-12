import 'package:backend/database_controller.dart';
import 'package:backend/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backend/login_screen.dart';

void main() {
  runApp(const MyApp());
  Get.put(DatabaseController());
  Get.put(UserDataController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => LoginScreen()),
        
      ],
    );
  }
}
