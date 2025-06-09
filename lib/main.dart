import 'package:flutter/material.dart';
import 'pages/not_found.dart';
import 'pages/index.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pictopal Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const IndexPage(),
      },
      debugShowCheckedModeBanner: false,
      onUnknownRoute:
          (settings) =>
              MaterialPageRoute(builder: (context) => const NotFoundPage()),
    );
  }
}
