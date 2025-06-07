import 'package:flutter/material.dart';

class ThemeSelector extends StatelessWidget {
  final void Function(String theme) onThemeSelect;
  final int stars;
  final List<String> stickers;

  const ThemeSelector({
    super.key,
    required this.onThemeSelect,
    required this.stars,
    required this.stickers,
  });

  final List<Map<String, dynamic>> themes = const [
    {
      'id': 'animals',
      'name': 'Animals',
      'emoji': '🐱',
      'gradient': [Color(0xFF4ADE80), Color(0xFF059669)], // green
      'description': 'Learn about cute animals!',
    },
    {
      'id': 'fruits',
      'name': 'Fruits',
      'emoji': '🍎',
      'gradient': [Color(0xFFFBBF24), Color(0xFFF59E42)], // orange
      'description': 'Discover yummy fruits!',
    },
    {
      'id': 'objects',
      'name': 'Objects',
      'emoji': '⚽',
      'gradient': [Color(0xFF60A5FA), Color(0xFF1D4ED8)], // blue
      'description': 'Explore everyday things!',
    },
    {
      'id': 'colors',
      'name': 'Colors',
      'emoji': '🌈',
      'gradient': [Color(0xFFA78BFA), Color(0xFF7C3AED)], // purple
      'description': 'Learn beautiful colors!',
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
              Center(
                child: Column(
                  children: [
                    Text(
                      'Choose a Theme!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pick a theme to start learning 🎨',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.purple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              // Theme Cards
              Expanded(
                child: ListView.separated(
                  itemCount: themes.length,
                  separatorBuilder: (_, __) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final theme = themes[index];
                    return GestureDetector(
                      onTap: () => onThemeSelect(theme['id']),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: List<Color>.from(theme['gradient']),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(22),
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
                            SizedBox(width: 28),
                            Text(
                              theme['emoji'],
                              style: TextStyle(fontSize: 44),
                            ),
                            SizedBox(width: 28),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    theme['name'],
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    theme['description'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 28),
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