import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Footer extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Footer({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(LucideIcons.listChecks), label: ''),
        BottomNavigationBarItem(icon: Icon(LucideIcons.users), label: ''),
        BottomNavigationBarItem(icon: Icon(LucideIcons.box), label: ''),
        BottomNavigationBarItem(icon: Icon(LucideIcons.settings), label: ''),
      ],
    );
  }
}
