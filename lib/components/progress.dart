import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  final int stars;
  final List<String> stickers;
  final Map<String, bool> completedLevels;

  ProgressScreen({
    super.key,
    required this.stars,
    required this.stickers,
    required this.completedLevels,
  });

  final List<String> staticStickers = [
    '🎉', '⭐', '🏆', '🎈', '🎁', '🌟', '🎊', '🏅'
  ];

  final List<Map<String, dynamic>> themes = [
    {'name': 'Animals', 'emoji': '🐱', 'key': 'animals', 'total': 3},
    {'name': 'Fruits', 'emoji': '🍎', 'key': 'fruits', 'total': 3},
    {'name': 'Objects', 'emoji': '⚽', 'key': 'objects', 'total': 3},
    {'name': 'Colors', 'emoji': '🌈', 'key': 'colors', 'total': 3},
  ];

  int getCompletedLevelsForTheme(String themeKey) {
    final levels = ['one', 'two', 'three'];
    return levels.where((level) => completedLevels['$themeKey-$level'] == true).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      'Your Progress! 📊',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "See how amazing you're doing! ⭐",
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

              // Overall Stats
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(Icons.star, size: 48, color: Colors.amber[400]),
                            SizedBox(height: 8),
                            Text(
                              '$stars',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[700],
                              ),
                            ),
                            Text(
                              'Total Stars',
                              style: TextStyle(
                                color: Colors.purple[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(Icons.emoji_events, size: 48, color: Colors.pink[300]),
                            SizedBox(height: 8),
                            Text(
                              '${stickers.length}',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[600],
                              ),
                            ),
                            Text(
                              'Stickers Earned',
                              style: TextStyle(
                                color: Colors.purple[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              // Theme Progress
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.emoji_events, color: Colors.amber[700]),
                          SizedBox(width: 8),
                          Text(
                            'Theme Progress',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ...themes.map((theme) {
                        final completed = getCompletedLevelsForTheme(theme['key']);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Text(theme['emoji'], style: TextStyle(fontSize: 28)),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          theme['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.purple[700],
                                          ),
                                        ),
                                        Text(
                                          '$completed/${theme['total']}',
                                          style: TextStyle(
                                            color: Colors.purple[500],
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.purple[100],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          height: 8,
                                          width: (completed / theme['total']) *
                                              MediaQuery.of(context).size.width *
                                              0.5,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.purple[300]!,
                                                Colors.purple[700]!
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),

              // Sticker Collection
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.emoji_emotions, color: Colors.pink[400]),
                          SizedBox(width: 8),
                          Text(
                            'Sticker Collection',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[800],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: staticStickers.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final unlocked = index < stickers.length;
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: unlocked
                                    ? [Colors.pink[50]!, Colors.purple[50]!]
                                    : [Colors.grey[200]!, Colors.grey[300]!],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                unlocked ? staticStickers[index] : '🔒',
                                style: TextStyle(fontSize: 32),
                              ),
                            ),
                          );
                        },
                      ),
                      if (stickers.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: Text(
                              'Complete quizzes to unlock stickers!',
                              style: TextStyle(
                                color: Colors.purple[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}