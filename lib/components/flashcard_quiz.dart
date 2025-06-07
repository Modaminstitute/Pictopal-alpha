import 'package:flutter/material.dart';
import '../utils/speech_utils.dart';
import '../utils/syllable_map.dart';

class FlashcardQuiz extends StatefulWidget {
  final String theme;
  final String level;
  final List<Flashcard> flashcards;
  final void Function(bool isCorrect) onAnswer;
  final VoidCallback onComplete;
  final VoidCallback onBack;

  const FlashcardQuiz({
    Key? key,
    required this.theme,
    required this.level,
    required this.flashcards,
    required this.onAnswer,
    required this.onComplete,
    required this.onBack,
  }) : super(key: key);

  @override
  State<FlashcardQuiz> createState() => _FlashcardQuizState();
}

class _FlashcardQuizState extends State<FlashcardQuiz> {
  int currentIndex = 0;
  bool showAnswer = false;
  int correctAnswers = 0;
  int totalAnswers = 0;

  void _handleAnswer(bool isCorrect) {
    setState(() {
      totalAnswers++;
      if (isCorrect) correctAnswers++;
    });
    
    widget.onAnswer(isCorrect);
    
    // Show feedback
    _showFeedback(isCorrect);
    stopSpeech();

    // Move to next card after delay
    Future.delayed(Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          showAnswer = false;
          if (currentIndex < widget.flashcards.length - 1) {
            currentIndex++;
          } else {
            widget.onComplete();
          }
        });
      }
    });
  }

  void _showFeedback(bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect ? 'Correct! 🎉' : 'Wrong! 😅',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  void _back() {
    widget.onBack();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz - ${widget.theme}'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _back,
          ),
        ),
        body: Center(
          child: Text(
            'Tidak ada soal quiz untuk level ini',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    if (currentIndex >= widget.flashcards.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Done'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events,
                size: 80,
                color: Colors.amber,
              ),
              SizedBox(height: 24),
              Text(
                'Quiz Done!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple[800],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your Score: $correctAnswers/$totalAnswers',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.purple[600],
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: widget.onComplete,
                icon: Icon(Icons.home),
                label: Text('Back to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final flashcard = widget.flashcards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${widget.theme}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _back,
        ),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${currentIndex + 1}/${widget.flashcards.length}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Click the Card to See the Answer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            GestureDetector(
  onTap: () {
    setState(() {
      showAnswer = !showAnswer;
      if (showAnswer) {
        speakWithSyllables(
          flashcard.answer,
          getSyllablePronunciation(flashcard.answer),
        );
      } else {
        stopSpeech();
      }
    });
  },
  child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: showAnswer ? Colors.purple[50] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: showAnswer
                        ? Column(
                            key: ValueKey('answer'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lightbulb,
                                size: 32,
                                color: Colors.purple[600],
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Answer:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purple[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                flashcard.answer,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : Column(
  key: ValueKey('question'),
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    if (flashcard.image.isNotEmpty)
      Image.network(
        flashcard.image,
        height: 120,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stack) =>
            Icon(Icons.broken_image, size: 80, color: Colors.grey),
      ),
    SizedBox(height: 8),
    Icon(
      Icons.help_outline,
      size: 32,
      color: Colors.blue[600],
    ),
    SizedBox(height: 8),
    Text(
      'Question:',
      style: TextStyle(
        fontSize: 16,
        color: Colors.blue[600],
      ),
    ),
    SizedBox(height: 8),
    Text(
      flashcard.question,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.blue[800],
      ),
      textAlign: TextAlign.center,
    ),
  ],
),
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            if (showAnswer) ...[
              Text(
                'Is your answer correct?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _handleAnswer(true),
                    icon: Icon(Icons.check, color: Colors.white),
                    label: Text('Correct'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  SizedBox(width: 24),
                  ElevatedButton.icon(
                    onPressed: () => _handleAnswer(false),
                    icon: Icon(Icons.close, color: Colors.white),
                    label: Text('Wrong'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Text(
                'Think about your answer, then tap the card.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 32),
            LinearProgressIndicator(
              value: (currentIndex + 1) / widget.flashcards.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[600]!),
            ),
            SizedBox(height: 8),
            Text(
              'Current Score: $correctAnswers/$totalAnswers',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Flashcard {
  final String question;
  final String answer;
  final String image; // Tambahkan ini

  Flashcard({
    required this.question,
    required this.answer,
    required this.image,
  });
}