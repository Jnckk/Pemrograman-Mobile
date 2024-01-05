// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:merdeka_quiz/controller/controllers.dart';

class DatabaseController extends ClientController {
  static const String databaseId = "65872f33eb7eaa551dd7";
  static const String collectionId = "65872f4192768a1b1546";

  Databases? databases;

  @override
  void onInit() {
    super.onInit();
    databases = Databases(client);
  }

  Future<void> createDocument(Map<String, String> data) async {
    try {
      final result = await databases!.createDocument(
        databaseId: databaseId,
        documentId: ID.unique(),
        collectionId: collectionId,
        data: data,
      );

      print("DatabaseController:: createDocument $result");
    } catch (error) {
      print("DatabaseController:: createDocument Error: $error");
    }
  }

  Future<List<Document>> getAllDocuments() async {
    try {
      final response = await databases!.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
      );

      return response.documents;
    } catch (error) {
      print("DatabaseController:: getAllDocuments Error: $error");
      return [];
    }
  }

  Future<void> updateDocument(
      String documentId, Map<String, String> data) async {
    try {
      final result = await databases!.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data,
      );

      print("DatabaseController:: updateDocument $result");
    } catch (error) {
      print("DatabaseController:: updateDocument Error: $error");
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      final result = await databases!.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );

      print("DatabaseController:: deleteDocument $result");
    } catch (error) {
      print("DatabaseController:: deleteDocument Error: $error");
    }
  }
}
