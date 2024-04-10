import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CNavBar extends StatelessWidget {
  const CNavBar({super.key, required this.route});
  final StatefulNavigationShell route;

  @override
  Widget build(BuildContext context) {
    return  NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
            size: 28,
          ),
          label: 'Home',
          selectedIcon: Icon(
            FontAwesomeIcons.house,
            color: Colors.white,
            size: 26,
          ),
        ),
        NavigationDestination(
          icon: Icon(
            Icons.chat_bubble_outline,
            size: 24,
          ),
          label: 'Chats',
          selectedIcon: Icon(
            Icons.chat_bubble,
            color: Colors.white,
            size: 32,
          ),
        ),
        NavigationDestination(
          icon: Icon(
            Icons.video_collection_outlined,
            size: 26,
          ),
          label: 'Shorts',
          selectedIcon: Icon(
            Icons.video_collection,
            color: Colors.white,
            size: 32,
          ),
        ),
        NavigationDestination(
          icon: Icon(
            FontAwesomeIcons.person,
            size: 26,
          ),
          label: 'Account',
          selectedIcon: Icon(
            FontAwesomeIcons.person,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
      selectedIndex: route.currentIndex,
      onDestinationSelected: (index) {
        route.goBranch(index);
      },
    );
  }
}
