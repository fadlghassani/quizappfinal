import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/question_model.dart';
import '../models/db_connect.dart';
import '../widgets/option_card.dart';
import '../widgets/next_button.dart';
import '../widgets/result_box.dart';
import '../widgets/question_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBconnect db = DBconnect();
  late Future<List<Question>> _questionsFuture;

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;
  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    _questionsFuture = db.fetchQuestions();
  }

  void nextQuestion() {
    if (!isPressed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an option', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
        ),
      );
      return;
    }

    if (index == questions.length - 1) {
      showDialog(
        context: context,
        builder: (_) => ResultBox(
          result: score,
          questionLength: questions.length,
          onPressed: startOver,
        ),
      );
    } else {
      setState(() {
        index++;
        isPressed = false;
        isAlreadySelected = false;
      });
    }
  }

  void checkAnswer(bool value) {
    if (isAlreadySelected) return;
    if (value) score++;
    setState(() {
      isPressed = true;
      isAlreadySelected = true;
    });
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _questionsFuture,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: background,
            body: Center(child: CircularProgressIndicator(color: accent)),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: background,
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(
            backgroundColor: background,
            body: Center(
              child: Text('No questions found.', style: TextStyle(color: Colors.white)),
            ),
          );
        }

        if (questions.isEmpty) questions = snapshot.data!;
        final currentQuestion = questions[index];

        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            title: const Text('Quiz', style: TextStyle(color: Colors.white)),
            backgroundColor: background,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Score: $score', style: const TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: QuestionWidget(
                      indexAction: index,
                      question: currentQuestion.title,
                      totalQuestions: questions.length,
                    ),
                  ),
                ),
                ...currentQuestion.options.entries.map((entry) {
                  return GestureDetector(
                    onTap: () => checkAnswer(entry.value),
                    child: OptionCard(
                      option: entry.key,
                      color: isPressed
                          ? (entry.value ? correct : incorrect)
                          : neutral,
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                NextButton(onPressed: nextQuestion),
              ],
            ),
          ),
        );
      },
    );
  }
}
 