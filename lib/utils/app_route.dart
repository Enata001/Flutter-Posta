import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/features/authentication/screens/auth_screen.dart';
import 'package:posta/features/authentication/screens/forgot_password_screen.dart';
import 'package:posta/features/chats/screens/chats_screen.dart';
import 'package:posta/features/dashboard/screens/dash_screen.dart';
import 'package:posta/features/posts/screens/post_screen.dart';
import 'package:posta/features/profile/screens/profile_screen.dart';
import 'package:posta/features/shorts/screens/shorts_screen.dart';
import 'package:posta/providers/auth_state_notifier.dart';
import 'Navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoute {
  // GoRouter router = GoRouter(
  //   initialLocation: Navigation.entry,
  //   routes: [
  //     GoRoute(
  //       path: Navigation.entry,
  //       name: Navigation.entry,
  //       builder: (context, state) => const HomeScreen(),
  //       redirect: (context, state) {
  //         final result = context.monitor(isLoggedInProvider);
  //
  //         if (result) return Navigation.entry;
  //         return '/${Navigation.authPage}';
  //       },
  //     ),
  //     GoRoute(
  //       path: '/${Navigation.authPage}',
  //       name: Navigation.authPage,
  //       builder: (context, state) => const AuthScreen(),
  //
  //     ),
  //   ],
  // );
  static final routeProvider = Provider(
    (ref) {
      final isLoggedIn = ref.watch(isLoggedInProvider);
      return GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/auth_page',
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: '/${Navigation.authPage}',
            name: Navigation.authPage,
            builder: (context, state) => const AuthScreen(),
            routes: [
              GoRoute(
                path: Navigation.forgotPassword,
                name: Navigation.forgotPassword,
                builder: (context, state) => const ForgotPasswordScreen(),
              ),
            ],
          ),
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state, navigationShell) => DashScreen(
              route: navigationShell,
            ),
            branches: [
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: Navigation.entry,
                    path: Navigation.entry,
                    builder: (context, state) => const PostsScreen(),
                    // redirect: (context, state) {
                    //   if (isLoggedIn) return Navigation.entry;
                    //   return '/${Navigation.authPage}';
                    // },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: Navigation.chats,
                    path: "/${Navigation.chats}",
                    builder: (context, state) => const ChatsScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: Navigation.shorts,
                    path: "/${Navigation.shorts}",
                    builder: (context, state) => ShortsScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: Navigation.account,
                    path: "/favourites",
                    builder: (context, state) => const ProfileScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
