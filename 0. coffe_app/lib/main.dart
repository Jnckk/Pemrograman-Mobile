import 'package:coffe_app/appwrite/appwrite.dart';
import 'package:coffe_app/controllers/controllers.dart';
import 'package:coffe_app/views/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  Get.put(CoffeeController());
  Get.put(DatabaseController());
  Get.put(UserDataController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessagingHandler().initPushNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ImagePickerController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      theme: ThemeData.dark(),
      getPages: [
        GetPage(name: '/home', page: () => const HomePageView()),
        GetPage(name: '/coffee', page: () => CoffeeView()),
        GetPage(name: '/profile', page: () => const FirebaseProfile()),
        GetPage(name: '/login', page: () => LoginScreen()),
      ],
    );
  }
}
