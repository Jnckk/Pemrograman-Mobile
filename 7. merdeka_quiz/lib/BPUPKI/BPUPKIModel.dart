// ignore_for_file: file_names

class BPUPKIModel {
  List<Question> questions = [
    Question(
      'Kapan BPUPKI dibentuk?',
      ['29 April 1945', '22 Juni 1945', '1 Maret 1946', '1 November 1945'],
      '29 April 1945',
    ),
    Question(
      'Siapakah Ketua BPUPKI?',
      [
        'Soekarno',
        'Dr. Radjiman Wedyodiningrat',
        'Abdul Karim',
        'Sutan Sjahrir'
      ],
      'Dr. Radjiman Wedyodiningrat',
    ),
    Question(
      'Apa singkatan dari BPUPKI?',
      [
        'Badan Penyelidik Usaha-usaha Persiapan Kemerdekaan Indonesia',
        'Badan Perjuangan Untuk Kemerdekaan Indonesia',
        'Badan Pekerja Untuk Persiapan Kemerdekaan Indonesia',
        'Badan Penyelidik Usaha Persiapan Kemerdekaan Istimewa'
      ],
      'Badan Penyelidik Usaha-usaha Persiapan Kemerdekaan Indonesia',
    ),
    Question(
      'Siapa wakil ketua BPUPKI?',
      [
        'Soekarno',
        'Mohammad Hatta',
        'Ichibangase Yosio (Jepang) dan Raden Pandji Soeroso.',
        'Sutan Sjahrir'
      ],
      'Ichibangase Yosio (Jepang) dan Raden Pandji Soeroso.',
    ),
    Question(
      'Apa tujuan pembentukan BPUPKI?',
      [
        'Memperjuangkan kemerdekaan Indonesia',
        'Melakukan penelitian untuk persiapan kemerdekaan',
        'Mencari solusi untuk masalah ekonomi Indonesia',
        'Menjaga keamanan Indonesia'
      ],
      'Melakukan penelitian untuk persiapan kemerdekaan',
    ),
  ];
}

class Question {
  String questionText;
  List<String> options;
  String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
