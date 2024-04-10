import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/providers/theme_provider.dart';

import '../utils/app_route.dart';

// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//
//   final GoRouter router = AppRoute().router;
//
//   @override
//   Widget build(BuildContext context) {
//     return App(
//       router: router,
//     );
//   }
// }

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(AppRoute.routeProvider);
    return MaterialApp.router(
      themeAnimationDuration: const Duration(
        milliseconds: 200,
      ),
      themeAnimationCurve: Easing.emphasizedDecelerate,
      debugShowCheckedModeBanner: false,
      theme: theme.theme,
      routerConfig: router,
    );
  }
}
