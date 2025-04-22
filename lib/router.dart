import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:labchat/screens/chat/chat.room.screen.dart';
import 'package:labchat/screens/entry/entry.screen.dart';
import 'package:labchat/screens/home/home.screen.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey();
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// GoRouter
final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  redirect: (context, state) {
    if (state.fullPath == EntryScreen.routeName) {
      return null;
    } else {
      if ('loggedIn' != 'loggedIn') {
        return EntryScreen.routeName;
      } else {
        return null;
      }
    }
  },
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: EntryScreen.routeName,
      name: EntryScreen.routeName,
      pageBuilder:
          (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: const EntryScreen(),
          ),
    ),

    GoRoute(
      path: ChatRoomScreen.routeName,
      name: ChatRoomScreen.routeName,
      builder: (context, state) => const ChatRoomScreen(),
    ),
  ],
);
