import 'question_model.dart';

// List of questions
final List<Question> questions = [
  Question(
    id: '1', 
    title: "What is Flutter?",
    options: {
      "A UI toolkit": true,
      "A programming language": false,
      "A database": false,
      "A cloud service": false,
    },
  ),
  Question(
    id: '2', 
    title: "Which language does Flutter use?",
    options: {
      "Java": false,
      "Dart": true,
      "Python": false,
      "C++": false,
    },
  ),

];
