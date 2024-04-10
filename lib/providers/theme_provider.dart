import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posta/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = AppTheme.lightTheme;

  ThemeData get theme => _theme;

  set newTheme(ThemeData theme) {
    _theme = theme;
    notifyListeners();
  }

  void changeTheme() {
    if (_theme == AppTheme.lightTheme) {
      newTheme = AppTheme.darkTheme;
    } else {
      newTheme = AppTheme.lightTheme;
    }
  }
}

final themeProvider = ChangeNotifierProvider(
  (ref) => ThemeProvider(),
);
