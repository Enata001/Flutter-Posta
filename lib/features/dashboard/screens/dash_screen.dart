import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/features/dashboard/notifier/nav_bar_notifier.dart';
import 'package:posta/features/dashboard/widgets/cnav_bar.dart';
import 'package:posta/providers/theme_provider.dart';
import 'package:posta/utils/constants.dart';
import 'package:posta/utils/dimensions.dart';
import 'package:posta/utils/themes.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({
    super.key,
    required this.route,
  });

  final StatefulNavigationShell route;

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  void dispose() {
    super.dispose();
    navBar.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.route.currentIndex == 2
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: Image.asset(
                    Constants.logoPath,
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Consumer(
                    builder: (builder, ref, child) {
                      final theme = ref.watch(themeProvider);
                      final darkTheme = theme.theme == AppTheme.darkTheme;
                      return OutlinedButton(
                        onPressed: () {
                          theme.changeTheme();
                        },
                        child: Icon(
                          darkTheme
                              ? FontAwesomeIcons.moon
                              : FontAwesomeIcons.sun,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      body: SafeArea(
        child: widget.route,
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: widget.route.currentIndex == 0
            ? navBar.visible
            : navBarChats.visible,
        builder: (context, bool value, child) {
          return AnimatedContainer(
            duration: const Duration(
              milliseconds: Dimensions.navBarDuration,
            ),
            height: value ? Dimensions.navBarHeight : 0.0,
            child: Visibility(
              visible: value,
              child: CNavBar(
                route: widget.route,
              ),
            ),
          );
        },
      ),
    );
  }
}
