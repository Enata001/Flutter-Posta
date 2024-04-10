import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:posta/utils/dimensions.dart';

class ShortsScreen extends StatelessWidget {
  ShortsScreen({super.key});

  final List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 20; i++) {
      list.add(
        Stack(
          children: [
            Container(
              color: Color.fromARGB(
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
                Random().nextInt(255),
              ),
              height:
                  MediaQuery.sizeOf(context).height - Dimensions.navBarHeight,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      FontAwesomeIcons.thumbsUp,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      FontAwesomeIcons.thumbsDown,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      FontAwesomeIcons.comment,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      FontAwesomeIcons.share,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: list,
      ),
    );
  }
}
