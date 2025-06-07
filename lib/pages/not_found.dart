import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('404', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Oops! Page not found', style: TextStyle(fontSize: 20, color: Colors.grey[700])),
            SizedBox(height: 24),
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              child: Text('Return to Home', style: TextStyle(color: Colors.blue, fontSize: 16, decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ),
    );
  }
}