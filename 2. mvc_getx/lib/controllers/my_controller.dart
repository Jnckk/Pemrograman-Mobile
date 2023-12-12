// my_controller.dart
import 'package:get/get.dart';

class MyController extends GetxController {
  // Observable variable
  RxInt counter = 0.obs;

  void incrementCounter() {
    counter++;
  }
}
