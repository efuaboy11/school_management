import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentTab extends StatelessWidget {
  const StudentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    int currentIndex = 0;
    if (location.startsWith('/student/home')) currentIndex = 0;
    if (location.startsWith('/store')) currentIndex = 1;
    if (location.startsWith('/help')) currentIndex = 2;
    if (location.startsWith('/profile')) currentIndex = 3;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/student/home');
            break;
          case 1:
            context.go('/login');
            break;
          case 2:
            context.go('/student/fees-history');
            break;
          case 3:
            context.go('/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Store',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: 'Help',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
