import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing/latihan/unit/api_service.dart';
import 'package:testing/latihan/unit/posts_model.dart';
import 'api_service_test.mocks.dart';
// Run => flutter test test/latihan/data/api_service_test.dart

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('Posts Model Tests', () {
    test('Test Posts.fromJson()', () {
      // Test case for Posts.fromJson() method
      final postsJson = {
        "userId": 1,
        "id": 1,
        "title": "Test Title",
        "body": "Test Body",
      };

      final result = Posts.fromJson(postsJson);

      expect(result.userId, 1);
      expect(result.id, 1);
      expect(result.title, "Test Title");
      expect(result.body, "Test Body");
    });

    test('Test Posts.toJson()', () {
      // Test case for Posts.toJson() method
      final posts = Posts(
        userId: 1,
        id: 1,
        title: "Test Title",
        body: "Test Body",
      );

      final result = posts.toJson();

      expect(result['userId'], 1);
      expect(result['id'], 1);
      expect(result['title'], "Test Title");
      expect(result['body'], "Test Body");
    });
  });

  group('API Service Tests', () {
    test('Test fetchPosts function', () async {
      final apiService = ApiService();
      final mockClient = MockClient();

      // Mock HTTP response
      when(mockClient.get(any)).thenAnswer((_) async => http.Response(
          jsonEncode({
            "userId": 1,
            "id": 1,
            "title": "Test Title",
            "body": "Test Body",
          }),
          200));

      final result = await apiService.fetchPosts(mockClient);

      // Replace the expected values with the values from the mocked response
      expect(result.userId, 1);
      expect(result.id, 1);
      expect(result.title, "Test Title");
      expect(result.body, "Test Body");
    });
  });
}
