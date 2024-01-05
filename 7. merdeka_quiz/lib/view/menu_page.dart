// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merdeka_quiz/BPUPKI/BPUPKI.dart';
import 'package:merdeka_quiz/Perumusan/perumusan.dart';
import 'package:merdeka_quiz/Rengasdengklok/Rengas.dart';
import 'package:merdeka_quiz/Yamato/yamato.dart';
import 'package:merdeka_quiz/view/views.dart';

class MenuPage extends GetView {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 200),
                  InkWell(
                    onTap: () {
                      print('Bagian 1 diklik');
                      Get.to(() => const BPUPKIView());
                    },
                    child: Image.asset(
                      'assets/menu/bagian1.png',
                      width: deviceWidth * 0.9,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Bagian 2 diklik');
                      Get.to(() => const RengasView());
                    },
                    child: Image.asset(
                      'assets/menu/bagian2.png',
                      width: deviceWidth * 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Bagian 3 diklik');
                      Get.to(() => const PerumusanView());
                    },
                    child: Image.asset(
                      'assets/menu/bagian3.png',
                      width: deviceWidth * 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      print('Bagian 4 diklik');
                      Get.to(() => const YamatoView());
                    },
                    child: Image.asset(
                      'assets/menu/bagian4.png',
                      width: deviceWidth * 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 65,
            right: 16,
            child: IconButton(
              icon: const Icon(
                Icons.person,
                size: 40,
              ),
              onPressed: () {
                Get.to(() => Profile());
                print('User icon clicked');
              },
            ),
          ),
        ],
      ),
    );
  }
}
