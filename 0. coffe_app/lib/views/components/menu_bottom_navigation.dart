import 'package:coffe_app/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffe_app/views/pages/pages.dart';

class MenuBottomNavigation extends StatelessWidget {
  const MenuBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFFC67C4E);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.to(()=>const HomePageView());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: const Icon(Icons.home),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(()=>CoffeeView());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: const Icon(Icons.menu),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: const Icon(Icons.shopping_cart),
        ),
        ElevatedButton(
          onPressed: () {
            // Get.to(()=>LoginScreen());
            Get.to(() => const FirebaseProfile());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: const Icon(Icons.person),
        ),
      ],
    );
  }
}
