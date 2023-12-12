// main.dart

import 'package:api/controllers/todos_controller.dart';
import 'package:api/views/todos_views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TodosController todosController = Get.put(TodosController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
        ),
        body: TodosViews(todosController: todosController),
      ),
    );
  }
}
