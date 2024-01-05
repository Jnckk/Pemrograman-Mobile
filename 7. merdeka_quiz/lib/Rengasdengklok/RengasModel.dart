// ignore_for_file: file_names

class RengasModel {
  List<Question> questions = [
    Question(
      'Pertemuan tokoh-tokoh proklamator Indonesia yang terkenal, seperti Soekarno dan Hatta, dalam konteks peristiwa Rengasdengklok terjadi pada tanggal?',
      [
        '17 Agustus 1945',
        '19 September 1945',
        '17 Agustus 1946',
        '19 Desember 1945'
      ],
      '19 September 1945',
    ),
    Question(
      'Peristiwa Rengasdengklok merupakan suatu usaha dari sejumlah pemuda dan perwira militer yang ingin mengembalikan kekuasaan kepada?',
      ['Belanda', 'Jepang', 'Sekutu', 'Pemerintah Indonesia yang sah'],
      'Pemerintah Indonesia yang sah',
    ),
    Question(
      'Tempat terjadinya peristiwa Rengasdengklok terletak di wilayah?',
      ['Jakarta Selatan', 'Bekasi', 'Bogor', 'Karawang'],
      'Jakarta Selatan',
    ),
    Question(
      'Peristiwa Rengasdengklok sebenarnya terjadi sebagai reaksi terhadap tindakan pihak-pihak yang ingin membawa Soekarno dan Hatta ke dalam pesawat menuju?',
      ['Belanda', 'Inggris', 'Amerika Serikat', 'Australia'],
      'Belanda',
    ),
    Question(
      'Tokoh militer yang terlibat aktif dalam peristiwa Rengasdengklok dan menjadi salah satu pemimpin Gerakan 30 September (G30S) adalah?',
      [
        'Jenderal Sudirman',
        'Letnan Kolonel Untung',
        'Mayor Jenderal Soeharto',
        'Kolonel Ahmad Yani'
      ],
      'Letnan Kolonel Untung',
    ),
  ];
}

class Question {
  String questionText;
  List<String> options;
  String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
