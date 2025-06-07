import 'package:flutter/material.dart';
import '../data/learning_items.dart';
import '../utils/speech_utils.dart';
import '../utils/syllable_map.dart';

class LearningSession extends StatefulWidget {
  final String theme;
  final String level;
  final List items;
  final VoidCallback onComplete;
  final VoidCallback onBack;

  const LearningSession({
    super.key,
    required this.theme,
    required this.level,
    required this.items,
    required this.onComplete,
    required this.onBack,
  });

  @override
  State<LearningSession> createState() => _LearningSessionState();
}

class _LearningSessionState extends State<LearningSession> {
  int currentIndex = 0;
  bool isPlaying = false;
  int currentSyllableIndex = -1;

  @override
  

  void _playAudio() async {
    setState(() => isPlaying = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isPlaying = false);
  }

  void _next() {
    if (currentIndex < widget.items.length - 1) {
      setState(() => currentIndex++);
    } else {
      widget.onComplete();
    }
  }

  void _back() {
    widget.onBack();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.theme} - ${widget.level}'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _back,
          ),
        ),
        body: Center(
          child: Text(
            'Tidak ada materi pembelajaran untuk level ini',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final item = widget.items[currentIndex];
    
    // Debug current item
    print('Current item type: ${item.runtimeType}');
    print('Current item: $item');
    
    String word;
    String? imageUrl;
    
    if (item is LearningItem) {
      // Jika item adalah LearningItem
      word = item.name;
      imageUrl = item.image;
      print('Using LearningItem - word: $word, image: $imageUrl');
    } else if (item is Map) {
      // Jika item adalah Map
      word = item['word'] ?? item['name'] ?? 'Unknown';
      imageUrl = item['imageUrl'] ?? item['image'];
      print('Using Map - word: $word, image: $imageUrl');
    } else {
      // Fallback
      word = item.toString();
      imageUrl = null;
      print('Using fallback - word: $word');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.theme} - ${widget.level}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _back,
        ),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // --- Standardized Header ---
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.08),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.purple[400], size: 40),
                      SizedBox(height: 8),
                      Text(
                        'Learn a New Word!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[800],
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Practice and listen to the word',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.purple[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              
              // Image Container - Reduced size
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            print('Image error: $error');
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Gambar tidak dapat dimuat',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 48,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'No Image',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(height: 24),
              
              // Word Display
              Text(
                word,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isPlaying ? Colors.orange : Colors.purple[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              
              // Audio Button
              ElevatedButton.icon(
  onPressed: isPlaying
      ? null
      : () async {
          setState(() => isPlaying = true);
          await speakWithSyllables(
           item.name,
            getSyllablePronunciation(item.name),
            onSyllableStart: (i) {
            setState(() => currentSyllableIndex = i);
            },
         onComplete: () {
         setState(() {
           isPlaying = false;
           currentSyllableIndex = -1;
            });
           },
      );
        },
  icon: Icon(Icons.volume_up),
  label: Text('Listen'),
),
              SizedBox(height: 24),
              
              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (currentIndex > 0)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: ElevatedButton.icon(
                          onPressed: () => setState(() => currentIndex--),
                          icon: Icon(Icons.arrow_back),
                          label: Text('Previous'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            foregroundColor: Colors.white,
                            minimumSize: Size(0, 48),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: currentIndex > 0 ? 8 : 0),
                      child: ElevatedButton.icon(
                        onPressed: _next,
                        icon: Icon(currentIndex < widget.items.length - 1 
                            ? Icons.arrow_forward 
                            : Icons.check),
                        label: Text(currentIndex < widget.items.length - 1 
                            ? 'Next' 
                            : 'Done'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          minimumSize: Size(0, 48),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Progress Indicator
              LinearProgressIndicator(
                value: (currentIndex + 1) / widget.items.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[600]!),
              ),
              SizedBox(height: 8),
              Text(
                '${currentIndex + 1} dari ${widget.items.length}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}