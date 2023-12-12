// controllers/todos_controller.dart


import 'dart:convert';

import 'package:api/models/todos_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TodosController extends GetxController {
  var isLoading = true.obs;
  var todo = Todos(userId: 0, id: 0, title: '', completed: false).obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodo();
  }

  void fetchTodo() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/5"));

      if (response.statusCode == 200) {
        todo(Todos.fromJson(json.decode(response.body)));
      }
    } finally {
      isLoading(false);
    }
  }
}
