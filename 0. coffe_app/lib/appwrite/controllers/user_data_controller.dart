// ignore_for_file: avoid_print

import 'package:appwrite/models.dart';
import 'database_controller.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController {
  final DatabaseController _databaseController = Get.find<DatabaseController>();
  RxList<Map<String, dynamic>> userDataList = <Map<String, dynamic>>[].obs;


  Future<void> getUserData(String userEmail) async {
    try {
      final List<Map<String, dynamic>> documents = [];
      final List<Document> databaseDocuments =
          await _databaseController.getAllDocuments();

      for (final Document document in databaseDocuments) {
        if (document.data['Email'] == userEmail) {
          documents.add(document.data);
        }
      }

      userDataList.assignAll(documents);
      print("User Data: $userDataList");
    } catch (error) {
      print("UserDataController:: getUserData Error: $error");
    }
  }

  Future<void> deleteUserData(String userEmail) async {
    try {
      final List<Document> databaseDocuments =
          await _databaseController.getAllDocuments();

      for (final Document document in databaseDocuments) {
        if (document.data['Email'] == userEmail) {
          await _databaseController.deleteDocument(document.$id);
          break; // Stop after deleting the first matching document
        }
      }

      // Refresh user data list after deletion
      await getUserData(userEmail);
    } catch (error) {
      print("UserDataController:: deleteUserData Error: $error");
    }
  }
}
