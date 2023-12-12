import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  Client client = Client();

  @override
  void onInit() {
    super.onInit();

    // Appwrite configuration
    const endPoint = "https://cloud.appwrite.io/v1";
    const projectID = "65662aa9319c829fdac1";

    client
        .setEndpoint(endPoint)
        .setProject(projectID)
        .setSelfSigned(status: true);
  }
}
