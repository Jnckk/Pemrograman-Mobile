import 'package:coffe_app/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class MenuGridView extends StatelessWidget {
  final CoffeeController coffeeController = Get.find<CoffeeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (coffeeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (coffeeController.coffeMenuList.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: coffeeController.coffeMenuList.length,
            itemBuilder: (context, index) {
              final coffeeMenu = coffeeController.coffeMenuList[index];
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      coffeeMenu.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                    const SizedBox(height: 16),
                    Text(coffeeMenu.title),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Failed to load data.'));
        }
      },
    );
  }
}
