class wordsJSON {
  String? kafigna;
  String? amharic;
  String? english;

  wordsJSON(
    this.kafigna,
    this.amharic,
    this.english,
  );
  wordsJSON.fromJson(Map<String, dynamic> json) {
    kafigna = json['kafigna'];
    amharic = json['Amharic'];
    english = json['English'];
  }
}
