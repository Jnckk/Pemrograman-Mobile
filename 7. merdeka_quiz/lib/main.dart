import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merdeka_quiz/controller/controllers.dart';
import 'package:merdeka_quiz/view/views.dart';

void main() {
  runApp(const MyApp());
  Get.put(DatabaseController());
  Get.put(UserDataController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MenuPage(),
      home: Startup(),
    );
  }
}
