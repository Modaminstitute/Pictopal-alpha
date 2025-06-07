import 'learning_items.dart';
import 'quiz_question.dart';
import 'dart:math';

List<QuizQuestion> generateQuizQuestions(List<LearningItem> items) {
  if (items.length < 2) return [];
  final random = Random();
  List<QuizQuestion> questions = [];

  for (var item in items) {
    // Pilih satu item lain sebagai wrong answer
    var wrongOptions = items.where((i) => i.id != item.id).toList();
    if (wrongOptions.isEmpty) continue;
    var wrongItem = wrongOptions[random.nextInt(wrongOptions.length)];

    questions.add(QuizQuestion(
      correctAnswer: item.name,
      wrongAnswer: wrongItem.name,
      image: item.image,
    ));
  }
  return questions;
}