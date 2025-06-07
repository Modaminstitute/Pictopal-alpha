import 'package:flutter/material.dart';
import '../utils/speech_utils.dart'; // Untuk TTS

class StoryScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const StoryScreen({super.key, required this.onFinish});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  String? selectedTheme;

  final List<Map<String, dynamic>> themes = [
    {
      'id': 'animals',
      'name': 'Animals',
      'emoji': '🐱',
      'gradient': [Color(0xFF4ADE80), Color(0xFF059669)],
    },
    {
      'id': 'fruits',
      'name': 'Fruits',
      'emoji': '🍎',
      'gradient': [Color(0xFFFBBF24), Color(0xFFF59E42)],
    },
    {
      'id': 'objects',
      'name': 'Objects',
      'emoji': '⚽',
      'gradient': [Color(0xFF60A5FA), Color(0xFF1D4ED8)],
    },
    {
      'id': 'colors',
      'name': 'Colors',
      'emoji': '🌈',
      'gradient': [Color(0xFFA78BFA), Color(0xFF7C3AED)],
    },
  ];

  final Map<String, List<StoryItem>> stories = {
    'animals': [
      StoryItem(
        text:
            'The curious cat leaped gracefully across the garden, chasing a bright butterfly that danced in the warm sunlight. As the butterfly fluttered higher, the cat paused and gazed at the sky, wondering what it would be like to fly. In that moment, the cat realized that sometimes, the joy is in the chase, not just the catch.',
        emoji: '🐱',
      ),
      StoryItem(
        text:
            'Late at night, a loyal dog sat by the window, barking softly at the glowing moon. He remembered the adventures of the day—running through fields, playing fetch, and making new friends. As he drifted to sleep, he dreamed of exploring new places and sharing his happiness with everyone he met.',
        emoji: '🐶',
      ),
      StoryItem(
        text:
            'At the riverbank, the playful elephant splashed cool water with its trunk, making its friends laugh with joy. The herd gathered around, trumpeting and spraying water into the air, creating rainbows in the sunlight. Together, they celebrated the beauty of friendship and the wonders of nature.',
        emoji: '🐘',
      ),
    ],
    'fruits': [
      StoryItem(
        text:
            'A shiny red apple fell from the tallest branch, rolling down the hill until it landed beside a friendly squirrel. The squirrel took a tiny bite and shared the apple with his friends, showing that kindness and sharing make every treat sweeter.',
        emoji: '🍎',
      ),
      StoryItem(
        text:
            'Bunches of ripe bananas hung from the tree, their sweet scent attracting a family of monkeys for a tasty breakfast. The monkeys peeled the bananas and enjoyed their meal together, laughing and swinging from branch to branch, grateful for the delicious feast.',
        emoji: '🍌',
      ),
      StoryItem(
        text:
            'Purple grapes grew in the sunny vineyard, each one bursting with flavor and waiting to be picked for a delicious treat. The children gathered the grapes in baskets, turning them into juice and jam, and learning that hard work and teamwork bring wonderful rewards.',
        emoji: '🍇',
      ),
    ],
    'objects': [
      StoryItem(
        text:
            'The soccer ball soared high above the field, as children cheered and chased after it with laughter and excitement. Every kick and pass brought them closer together, teaching them the value of teamwork and the joy of playing outdoors.',
        emoji: '⚽',
      ),
      StoryItem(
        text:
            'Opening the old book, a new world of magical stories and colorful characters came to life on every page. The reader traveled to distant lands, met brave heroes, and discovered that imagination can take you anywhere you wish to go.',
        emoji: '📖',
      ),
      StoryItem(
        text:
            'The little clock on the wall ticked steadily, reminding everyone that every moment is a chance for something wonderful. As the hands moved forward, the family gathered for dinner, sharing stories and laughter, and cherishing the time spent together.',
        emoji: '⏰',
      ),
    ],
    'colors': [
      StoryItem(
        text:
            'The sky was painted a brilliant blue, with fluffy clouds drifting lazily on a peaceful afternoon. Birds soared overhead, and the gentle breeze carried the scent of blooming flowers, filling the world with calm and happiness.',
        emoji: '💙',
      ),
      StoryItem(
        text:
            'Fresh green grass covered the meadow, sparkling with morning dew as the sun began to rise. Children ran barefoot through the field, their laughter echoing as they played hide and seek among the tall blades of grass.',
        emoji: '💚',
      ),
      StoryItem(
        text:
            'The bright yellow sun shone down, filling the world with warmth and happiness for everyone to share. Flowers opened their petals to greet the day, and people smiled as they enjoyed the golden light together.',
        emoji: '💛',
      ),
    ],
  };

  bool isSpeaking = false;
  int? speakingIndex;

  Future<void> _speakStory(String text, int index) async {
    if (isSpeaking && speakingIndex == index) {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
        speakingIndex = null;
      });
      return;
    }
    setState(() {
      isSpeaking = true;
      speakingIndex = index;
    });

    await flutterTts.setPitch(1.0); // Normal pitch
    await flutterTts.setSpeechRate(0.5); // Slower rate (default is 0.5, try 0.4 or 0.3 if still too fast)
    await flutterTts.setVolume(1.0);

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
        speakingIndex = null;
      });
    });
    flutterTts.setCancelHandler(() {
      setState(() {
        isSpeaking = false;
        speakingIndex = null;
      });
    });
    flutterTts.setErrorHandler((msg) {
      setState(() {
        isSpeaking = false;
        speakingIndex = null;
      });
    });

    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedTheme == null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Story Time!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Learning by listening',
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
                Expanded(
                  child: ListView.separated(
                    itemCount: themes.length,
                    separatorBuilder: (_, __) => SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final theme = themes[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTheme = theme['id'];
                          });
                        },
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
                                      _getThemeDescription(theme['id']),
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
    } else {
      final items = stories[selectedTheme] ?? [];
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Story Time',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.purple[800]),
            onPressed: () => setState(() => selectedTheme = null),
          ),
        ),
        backgroundColor: Colors.grey[100],
        body: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.celebration, color: Colors.white),
                    label: Text(
                      'Finish',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[600],
                      foregroundColor: Colors.white,
                      minimumSize: Size(180, 56),
                      shape: StadiumBorder(),
                      elevation: 4,
                      shadowColor: Colors.purple[200],
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          title: Column(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: Colors.amber,
                                size: 48,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Good Job!',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[800],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          content: Text(
                            'You finished reading the story. Keep learning and exploring!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purple[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[600],
                                foregroundColor: Colors.white,
                                shape: StadiumBorder(),
                                minimumSize: Size(120, 44),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Back to Home',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                      widget.onFinish();
                    },
                  ),
                ),
              );
            }
            final item = items[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (item.imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.imageUrl!,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (item.emoji != null)
                      Text(item.emoji!, style: TextStyle(fontSize: 48)),
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        item.text,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.purple[900],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(
                          (isSpeaking && speakingIndex == index)
                              ? Icons.stop_circle
                              : Icons.volume_up,
                          color: (isSpeaking && speakingIndex == index)
                              ? Colors.red
                              : Colors.purple[400],
                        ),
                        tooltip: (isSpeaking && speakingIndex == index)
                            ? 'Stop'
                            : 'Listen to Story',
                        onPressed: () => _speakStory(item.text, index),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  String _getThemeDescription(String id) {
    switch (id) {
      case 'animals':
        return 'Fun animal stories!';
      case 'fruits':
        return 'Tales about fruits!';
      case 'objects':
        return 'Stories of objects!';
      case 'colors':
        return 'Colorful adventures!';
      default:
        return '';
    }
  }
}

class StoryItem {
  final String text;
  final String? imageUrl;
  final String? emoji;

  StoryItem({required this.text, this.imageUrl, this.emoji});
}