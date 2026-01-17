class Kanji {
  final String character;
  final List<String> kunyomi;
  final List<String> onyomi;
  final List<String> meanings;
  final String jlpt;

  Kanji({
    required this.character,
    required this.kunyomi,
    required this.onyomi,
    required this.meanings,
    required this.jlpt,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    return Kanji(
      character: json['kanji'],
      kunyomi: List<String>.from(json['kunyomi']),
      onyomi: List<String>.from(json['onyomi']),
      meanings: List<String>.from(json['meanings']),
      jlpt: json['jlpt'],
    );
  }
}
