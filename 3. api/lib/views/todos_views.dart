import 'package:api/controllers/todos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodosViews extends StatelessWidget {
  const TodosViews({
    Key? key,
    required this.todosController,
  }) : super(key: key);

  final TodosController todosController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        if (todosController.isLoading.value) {
          return const CircularProgressIndicator();
        } else {
          return Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the text vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center the text horizontally
            children: <Widget>[
              Text(
                'User ID:\n${todosController.todo.value.userId.toString()}\n',
                textAlign: TextAlign.center, // Center-align the text
              ),
              Text(
                'ID:\n${todosController.todo.value.id.toString()}\n',
                textAlign: TextAlign.center, // Center-align the text
              ),
              Text(
                'Title:\n${todosController.todo.value.title}\n',
                textAlign: TextAlign.center, // Center-align the text
              ),
              Text(
                'Completed: ${todosController.todo.value.completed.toString()}\n',
                textAlign: TextAlign.center, // Center-align the text
              ),
            ],
          );
        }
      }),
    );
  }
}
