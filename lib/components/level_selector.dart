import 'package:flutter/material.dart';

class LevelSelector extends StatelessWidget {
  final String theme;
  final void Function(String level) onLevelSelect;
  final VoidCallback onBack;

  const LevelSelector({
    super.key,
    required this.theme,
    required this.onLevelSelect,
    required this.onBack,
  });

  String getThemeEmoji(String theme) {
    switch (theme) {
      case 'animals':
        return '🐱';
      case 'fruits':
        return '🍎';
      case 'objects':
        return '⚽';
      case 'colors':
        return '🌈';
      default:
        return '📚';
    }
  }

  final List<Map<String, dynamic>> levels = const [
    {
      'id': 'one',
      'name': 'Level 1',
      'description': 'Simple words (1 syllable)',
      'emoji': '🌱',
      'gradient': [Color(0xFF4ADE80), Color(0xFF059669)], // green
    },
    {
      'id': 'two',
      'name': 'Level 2',
      'description': 'Medium words (2 syllables)',
      'emoji': '🌿',
      'gradient': [Color(0xFF60A5FA), Color(0xFF1D4ED8)], // blue
    },
    {
      'id': 'three',
      'name': 'Level 3',
      'description': 'Longer words (3+ syllables)',
      'emoji': '🌳',
      'gradient': [Color(0xFFA78BFA), Color(0xFF7C3AED)], // purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 28),
                    onPressed: onBack,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${getThemeEmoji(theme)} ${theme[0].toUpperCase()}${theme.substring(1)}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Choose your level! 🎯',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 48), // Spacer for symmetry
                ],
              ),
              SizedBox(height: 32),
              // Level Selection Grid
              Expanded(
                child: ListView.separated(
                  itemCount: levels.length,
                  separatorBuilder: (_, __) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final level = levels[index];
                    return GestureDetector(
                      onTap: () => onLevelSelect(level['id']),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: List<Color>.from(level['gradient']),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 24),
                            Text(
                              level['emoji'],
                              style: TextStyle(fontSize: 36),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    level['name'],
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    level['description'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}