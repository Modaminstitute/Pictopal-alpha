import 'package:flutter/material.dart';
import '../components/theme_selector.dart';
import '../components/level_selector.dart';
import '../components/learning_session.dart';
import '../components/flashcard_quiz.dart';
import '../components/progress.dart';
import '../components/story.dart';
import '../components/bottom_navigation.dart';
import '../data/learning_items.dart';
import '../data/quiz_generator.dart';
import '../data/quiz_question.dart';
import '../utils/syllable_map.dart';
import '../utils/speech_utils.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  String currentTab = 'home';
  String currentPhase = 'theme-selection';
  String? selectedTheme;
  String? selectedLevel;
  int stars = 0;
  List<String> stickers = [];
  Map<String, bool> completedLevels = {};

  void handleThemeSelect(String theme) {
    setState(() {
      selectedTheme = theme;
      currentPhase = 'level-selection';
    });
  }

  void handleLevelSelect(String level) {
    setState(() {
      selectedLevel = level;
      currentPhase = 'learning';
    });
  }

  void handleLearningComplete() {
    setState(() {
      currentPhase = 'quiz';
    });
  }

  void handleQuizComplete(int earnedStars, String stickerReward) {
    setState(() {
      stars += earnedStars;
      stickers.add(stickerReward);
      if (selectedTheme != null && selectedLevel != null) {
        final levelKey = '${selectedTheme!}-${selectedLevel!}';
        completedLevels[levelKey] = true;
      }
      currentPhase = 'theme-selection';
      selectedTheme = null;
      selectedLevel = null;
    });
  }

  void handleBackToLevelSelection() {
    setState(() {
      currentPhase = 'level-selection';
    });
  }

  void handleBackToLearning() {
    setState(() {
      currentPhase = 'learning';
    });
  }

  void handleTabChange(String tab) {
    setState(() {
      currentTab = tab;
      if (tab == 'home') {
        currentPhase = 'theme-selection';
        selectedTheme = null;
        selectedLevel = null;
      }
    });
  }

 Widget renderHomeContent() {
  // --- Siapkan flashcards untuk phase quiz ---
  final List<Flashcard> flashcards = (() {
    if (selectedTheme != null && selectedLevel != null) {
      final items = learningItems[selectedTheme]?[selectedLevel];
      print('selectedTheme: $selectedTheme');
      print('selectedLevel: $selectedLevel');
      print('items: $items');
      if (items != null && items.isNotEmpty) {
        final questions = generateQuizQuestions(List<LearningItem>.from(items));
        print('questions: $questions');
        final result = questions
    .map((q) => Flashcard(
          question: 'What is This?',
          answer: q.correctAnswer,
          image: q.image, // Tambahkan ini
        ))
    .toList();
        print('flashcards: $result');
        return result;
      }
    }
    return const <Flashcard>[];
  })();

  switch (currentPhase) {
    case 'theme-selection':
      return ThemeSelector(
        onThemeSelect: handleThemeSelect,
        stars: stars,
        stickers: stickers,
      );
    case 'level-selection':
      return selectedTheme != null
          ? LevelSelector(
              theme: selectedTheme!,
              onLevelSelect: handleLevelSelect,
              onBack: () => setState(() => currentPhase = 'theme-selection'),
            )
          : const SizedBox.shrink();
    case 'learning':
      return (selectedTheme != null && selectedLevel != null)
          ? LearningSession(
              theme: selectedTheme!,
              level: selectedLevel!,
              items: learningItems[selectedTheme]?[selectedLevel] ?? const [],
              onComplete: handleLearningComplete,
              onBack: handleBackToLevelSelection,
            )
          : const SizedBox.shrink();
    case 'quiz':
      return (selectedTheme != null && selectedLevel != null)
          ? FlashcardQuiz(
              theme: selectedTheme!,
              level: selectedLevel!,
              flashcards: flashcards,
              onAnswer: (bool isCorrect) {
                // Logic untuk handle jawaban benar/salah
              },
              onComplete: () {
                handleQuizComplete(3, 'sticker1');
              },
              onBack: handleBackToLearning,
            )
          : const SizedBox.shrink();
    default:
      return const SizedBox.shrink();
  }
}

Widget renderContent() {
  switch (currentTab) {
    case 'home':
      return renderHomeContent();
    case 'progress':
      return ProgressScreen(
        stars: stars,
        stickers: stickers,
        completedLevels: completedLevels,
      );
    case 'story':
      return StoryScreen(
        // Tambahkan parameter yang sesuai jika diperlukan oleh StoryScreen
        onFinish: () {
          setState(() {
            currentTab = 'home';
          });
        },
      );
    default:
      return renderHomeContent();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: renderContent(),
      ),
      bottomNavigationBar: BottomNavigation(
        activeTab: currentTab,
        onTabChange: handleTabChange,
      ),
    );
  }
}