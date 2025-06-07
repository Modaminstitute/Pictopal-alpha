import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChange;

  const BottomNavigation({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  int _getCurrentIndex() {
    switch (activeTab) {
      case 'home':
        return 0;
      case 'story':
        return 1;
      case 'progress':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(),
      onTap: (index) {
        switch (index) {
          case 0:
            onTabChange('home');
            break;
          case 1:
            onTabChange('story');
            break;
          case 2:
            onTabChange('progress');
            break;
        }
      },
      selectedItemColor: Colors.purple[600],
      unselectedItemColor: Colors.grey[500],
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Story',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'Progress',
        ),
      ],
    );
  }
}