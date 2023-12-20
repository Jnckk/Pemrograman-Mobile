// RUN => flutter test test/api/api_test.dart

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:coffe_app/controllers/coffee_controller.dart';
import 'package:coffe_app/models/coffee_menu.dart';

import 'api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Coffee Controller Tests', () {
    test('Test fetchCoffeeMenu function', () async {
      final coffeeController = CoffeeController();
      final mockClient = MockClient();

      // Mock HTTP response
      when(mockClient.get(any)).thenAnswer((_) async => http.Response(
            jsonEncode([
              {
                "title": "Cappuccino",
                "description": "A classic coffee drink",
                "ingredients": ["Espresso", "Steamed milk", "Foam"],
                "image": "cappuccino.jpg",
                "id": 1,
              },
              // Add more mock data as needed
            ]),
            200,
          ));

      // Call the fetchCoffeeMenu function with the mockClient
      coffeeController.fetchCoffeeMenu(mockClient);

      // Wait for the fetchCoffeeMenu to complete
      await Future.delayed(Duration.zero);

      // Validate the loading state
      expect(coffeeController.isLoading.value, true);

      // Validate the content of the Coffemenu object if the list is not empty
      if (coffeeController.coffeMenuList.isNotEmpty) {
        final Coffemenu coffeeMenu = coffeeController.coffeMenuList.first;
        expect(coffeeMenu.title, "Cappuccino");
        expect(coffeeMenu.description, "A classic coffee drink");
        expect(coffeeMenu.ingredients, ["Espresso", "Steamed milk", "Foam"]);
        expect(coffeeMenu.image, "cappuccino.jpg");
        expect(coffeeMenu.id, 1);
      }
    });
  });
}
