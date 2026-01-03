class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final Map<String, bool> parsedOptions = {};
    if (json['options'] != null) {
      json['options'].forEach((key, value) {
        parsedOptions[key.toString()] = value == true;
      });
    }
    return Question(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      options: parsedOptions,
    );
  }
}
