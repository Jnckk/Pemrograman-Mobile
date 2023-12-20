// ignore_for_file: use_key_in_widget_constructors

import 'package:coffe_app/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoffeeView extends StatelessWidget {
  final httpClient = http.Client();
  final CoffeeController coffeeController = Get.put(CoffeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee Menu"),
      ),
      body: Obx(() {
        if (coffeeController.coffeMenuList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            itemCount: coffeeController.coffeMenuList.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemBuilder: (context, index) {
              final coffee = coffeeController.coffeMenuList[index];
              return ListTile(
                leading: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    coffee.image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(coffee.title),
                subtitle: Text(
                  coffee.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text("ID: ${coffee.id.toString()}"),
              );
            },
          );
        }
      }),
    );
  }
}
