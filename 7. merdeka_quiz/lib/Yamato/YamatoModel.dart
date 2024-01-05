// ignore_for_file: file_names

class YamatoModel {
  List<Question> questions = [
    Question(
      'Siapakah yang menjadi penulis utama dalam merumuskan Teks Proklamasi Kemerdekaan Indonesia?',
      [
        'Soekarno',
        'Mohammad Hatta',
        'Soekarno dan Mohammad Hatta',
        'Muhammad Yamin'
      ],
      'Soekarno dan Mohammad Hatta',
    ),
    Question(
      'Kapan Teks Proklamasi Kemerdekaan Indonesia diresmikan?',
      [
        '17 Agustus 1945',
        '15 Agustus 1945',
        '18 Agustus 1945',
        '16 Agustus 1945'
      ],
      '17 Agustus 1945',
    ),
    Question(
      'Dimana Teks Proklamasi Kemerdekaan Indonesia pertama kali dibacakan?',
      [
        'Jalan Pegangsaan Timur No. 56',
        'Istana Merdeka',
        'Lapangan Ikada',
        'Rumah Soekarno di Jl. Proklamasi'
      ],
      'Jalan Pegangsaan Timur No. 56',
    ),
    Question(
      'Berapa jumlah kata dalam Teks Proklamasi Kemerdekaan Indonesia?',
      ['50 kata', '17 kata', '45 kata', '40 kata'],
      '45 kata',
    ),
    Question(
      'Siapakah yang mengetik naskah proklamasi?',
      ['Mohammad Hatta', 'Soekarno', 'Sayuti Melik', 'Mohammad Yamin'],
      'Sayuti Melik',
    ),
  ];
}

class Question {
  String questionText;
  List<String> options;
  String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
