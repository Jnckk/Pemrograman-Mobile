import 'dart:convert';

import 'package:coffe_app/models/models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CoffeeController extends GetxController {
  final RxBool isLoading = true.obs;
  var coffeMenuList = <Coffemenu>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoffeeMenu();
  }

  void fetchCoffeeMenu([mockClient]) async {
    isLoading.value = true;

    try {
      final uri = Uri.parse("https://api.sampleapis.com/coffee/hot");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        isLoading.value = false;

        final List<dynamic> data = json.decode(response.body);
        coffeMenuList.assignAll(
          data.map((e) => Coffemenu.fromJson(e)).toList(),
        );
      }
    } catch (_) {
      isLoading.value = false;
    }
  }
}
