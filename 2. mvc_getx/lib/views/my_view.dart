// my_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_getx/controllers/my_controller.dart';

class MyView extends StatelessWidget {
  final MyController controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            // Using GetX with an observable variable
            GetX<MyController>(
              builder: (controller) => Text(
                '${controller.counter.value}', // Access the observable variable value
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
