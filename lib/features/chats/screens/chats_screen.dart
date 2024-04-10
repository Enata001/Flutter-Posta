import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posta/features/dashboard/notifier/nav_bar_notifier.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: navBarChats.controller,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            height: 70,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
          );
        },
        itemCount: 20,
      ),
      floatingActionButton: ValueListenableBuilder(
          valueListenable: navBarChats.visible,
          builder: (context, bool value, child) {
            return Visibility(
              visible: value,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  FontAwesomeIcons.comment,
                ),
              ),
            );
          }),
    );
  }
}
