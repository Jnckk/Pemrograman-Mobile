// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:merdeka_quiz/Yamato/yamato.dart';
import 'package:merdeka_quiz/view/views.dart';

class YamatoView extends StatefulWidget {
  const YamatoView({super.key});

  get controller => null;

  @override
  _YamatoViewState createState() => _YamatoViewState();
}

class _YamatoViewState extends State<YamatoView> {
  final YamatoController controller = YamatoController();
  String? _selectedAnswer;
  String imagePath = 'assets/yamato/yamato1.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/bg-soal.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100),
              Image.asset(
                'assets/yamato/Header4.png',
                height: 50,
              ),
              const SizedBox(height: 50),
              Image.asset(
                imagePath,
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                controller.getCurrentQuestion().questionText,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ..._buildOptions(),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    _handleAnswer(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff895b43),
                  ),
                  child: Text(
                    controller.isLastQuestion() ? 'Selesai' : 'Selanjutnya',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOptions() {
    return controller.getCurrentQuestion().options.map((option) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff895b43),
        ),
        child: RadioListTile(
          title: Text(
            option,
            style: const TextStyle(color: Colors.white),
          ),
          value: option,
          groupValue: _selectedAnswer,
          onChanged: (value) {
            setState(() {
              _selectedAnswer = value;
            });
          },
          activeColor: const Color(0xff895b43),
        ),
      );
    }).toList();
  }

  void _handleAnswer(BuildContext context) {
    if (controller.isLastQuestion()) {
      String correctAnswer = controller.getCurrentQuestion().correctAnswer;
      bool isCorrect = _selectedAnswer != null &&
          _selectedAnswer!.toUpperCase() == correctAnswer.toUpperCase();

      controller.setAnswerResult(
          controller.getCurrentQuestionIndex(), isCorrect);

      if (isCorrect) {
        controller.incrementCorrectAnswers();
      }
      _showResultDialog(context);
    } else {
      String correctAnswer = controller.getCurrentQuestion().correctAnswer;
      bool isCorrect = _selectedAnswer != null &&
          _selectedAnswer!.toUpperCase() == correctAnswer.toUpperCase();

      controller.setAnswerResult(
          controller.getCurrentQuestionIndex(), isCorrect);
      if (isCorrect) {
        controller.incrementCorrectAnswers();
      }
      controller.nextQuestion();
      int currentIndex = controller.getCurrentQuestionIndex();
      if (currentIndex == 1) {
        imagePath = 'assets/yamato/yamato2.png';
      } else if (currentIndex == 2) {
        imagePath = 'assets/yamato/yamato3.png';
      } else if (currentIndex == 3) {
        imagePath = 'assets/yamato/yamato4.png';
      } else if (currentIndex == 4) {
        imagePath = 'assets/yamato/yamato5.png';
      }

      setState(() {
        _selectedAnswer = null;
      });
    }
  }

  void _showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Kuis Selesai'),
          content: Column(
            children: [
              const Text('Anda telah menyelesaikan kuis.'),
              const Text('Insiden hotal Yamato.'),
              const SizedBox(height: 10),
              Text('Jumlah Jawaban Benar: ${controller.correctAnswers}'),
              const SizedBox(height: 10),
              const Text('Hasil Jawaban:'),
              ..._buildAnswerResults(),
            ],
          ),
          backgroundColor: const Color(0xFFD4AF88),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                );
              },
              child: const Text('Tutup', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildAnswerResults() {
    return controller.answerResults.asMap().entries.map((entry) {
      int index = entry.key + 1;
      bool? isCorrect = entry.value;

      return ListTile(
        title: Text('Soal $index: ${isCorrect == true ? 'Benar' : 'Salah'}'),
      );
    }).toList();
  }
}
