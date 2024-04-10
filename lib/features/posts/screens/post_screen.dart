import 'package:flutter/material.dart';
import 'package:posta/features/dashboard/notifier/nav_bar_notifier.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: navBar.controller,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            height: 200,
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
          );
        },
        itemCount: 20,
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: navBar.visible,
          builder: (context, bool value, child) {
            return Visibility(
              visible: value,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  Icons.add_card,
                ),
              ),
            );
          }),
    );
  }
}
