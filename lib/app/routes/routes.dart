import 'package:flutter/material.dart';
import 'package:letsguess/app/views/main_menu_screen.dart';
import 'package:letsguess/app/views/wordle_screen.dart';
import 'package:letsguess/app/views/settings_screen.dart';
import 'package:letsguess/app/views/high_scores_screen.dart';

enum AppRoutes {
  home,
  game,
  settings,
  scores,
}

class Routes {
  static const String home = '/';
  static const String game = '/game';
  static const String settings = '/settings';
  static const String scores = '/scores';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (_) => const MainMenuScreen(),
      game: (_) => const WordleScreen(),
      settings: (_) => const SettingsScreen(),
      scores: (_) => const HighScoresScreen(),
    };
  }

  static String getRoutePath(AppRoutes route) {
    switch (route) {
      case AppRoutes.home:
        return home;
      case AppRoutes.game:
        return game;
      case AppRoutes.settings:
        return settings;
      case AppRoutes.scores:
        return scores;
    }
  }
}
