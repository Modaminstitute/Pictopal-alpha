import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

void initTts() {
  flutterTts.setLanguage('en-US'); // Atur ke bahasa Inggris Amerika
  flutterTts.setSpeechRate(0.5);   // (opsional) atur kecepatan bicara
}

Future<void> speakWithSyllables(
  String word,
  String syllablePronunciation, {
  Function(int index)? onSyllableStart,
  Function()? onComplete,
}) async {
  await flutterTts.setLanguage('en-US');
  final syllables = syllablePronunciation.split('-');
  for (int i = 0; i < syllables.length; i++) {
    onSyllableStart?.call(i);
    await flutterTts.speak(syllables[i]);
    await Future.delayed(const Duration(milliseconds: 700));
  }
  // Setelah semua suku kata, ucapkan kata utuh
  await flutterTts.speak(word);
  await Future.delayed(const Duration(milliseconds: 1000));
  onComplete?.call();
}

Future<void> stopSpeech() async {
  await flutterTts.stop();
}