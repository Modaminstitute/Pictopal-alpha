import 'package:flutter/material.dart';

class SyllableDisplay extends StatelessWidget {
  final String word;
  final String syllablePronunciation; // e.g. "ba-la-pi"
  final int currentSyllableIndex;
  final bool isPlaying;

  const SyllableDisplay({
    super.key,
    required this.word,
    required this.syllablePronunciation,
    required this.currentSyllableIndex,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    final syllables = syllablePronunciation.split('-');
    if (syllables.length == 1) {
      // Single syllable word - highlight the whole word
      return AnimatedDefaultTextStyle(
        duration: Duration(milliseconds: 300),
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: isPlaying && currentSyllableIndex == 0
              ? Colors.amber[700]
              : Colors.purple[800],
          shadows: isPlaying && currentSyllableIndex == 0
              ? [Shadow(color: Colors.yellow, blurRadius: 12)]
              : [],
        ),
        child: Text(word),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < syllables.length; i++) ...[
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: EdgeInsets.symmetric(horizontal: 2),
            decoration: isPlaying && currentSyllableIndex == i
                ? BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  )
                : null,
            child: Text(
              syllables[i],
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: isPlaying && currentSyllableIndex == i
                    ? Colors.amber[700]
                    : Colors.purple[800],
                shadows: isPlaying && currentSyllableIndex == i
                    ? [Shadow(color: Colors.yellow, blurRadius: 12)]
                    : [],
              ),
            ),
          ),
        ]
      ],
    );
  }
}