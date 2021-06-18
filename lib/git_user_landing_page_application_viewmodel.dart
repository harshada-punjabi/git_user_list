import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';

class GitUserLandingPageApplicationViewModel extends BaseViewModel {
  GitUserLandingPageApplicationViewModel();

  GitUserTheme _gitUserTheme = GitUserTheme.light;

  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData {
    switch (_gitUserTheme) {
      case GitUserTheme.light:
        return _themeData.copyWith(
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            accentColor: Colors.cyanAccent,
            backgroundColor: Colors.white60,
            appBarTheme: AppBarTheme(
                brightness: Brightness.light,
                color: Colors.white,
                textTheme: TextTheme(
                    headline6: TextStyle(
                        fontFamily: 'Montserrat', color: Colors.cyan)),
                iconTheme: IconThemeData(color: Colors.black)),
            primaryColor: Colors.cyan,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.cyan,
              selectionHandleColor: Colors.cyan,
              selectionColor: Colors.grey,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
              ),
              labelStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'Montserrat',
              ),
            ),
            textTheme: _themeData.textTheme.apply(fontFamily: 'Montserrat'),
            accentTextTheme:
            _themeData.accentTextTheme.apply(fontFamily: 'Montserrat'),
            primaryTextTheme:
            _themeData.primaryTextTheme.apply(fontFamily: 'Montserrat'),
            iconTheme: IconThemeData(
              color: Colors.cyan,
            ),
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.cyan.withOpacity(1),
              inactiveTrackColor: Colors.white60.withOpacity(.5),
              thumbColor: Colors.cyan,
              trackHeight: 4.5,
              overlayColor: Colors.white60.withOpacity(.4),
              activeTickMarkColor: Colors.transparent,
              disabledInactiveTickMarkColor: Colors.transparent,
              disabledActiveTickMarkColor: Colors.transparent,
              disabledThumbColor: Colors.black,
              showValueIndicator: ShowValueIndicator.always,
              inactiveTickMarkColor: Colors.transparent,
            ));
      case GitUserTheme.dark:
        return _themeData.copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.amber,
        );
    }
  }

  set gitUserTheme(GitUserTheme value) {
    _gitUserTheme = value;
    notifyListeners();
  }

  toggleTheme() {
    if (_gitUserTheme == GitUserTheme.dark) {
      gitUserTheme = GitUserTheme.light;
    } else {
      gitUserTheme = GitUserTheme.dark;
    }
  }
}

enum GitUserTheme {
  dark,
  light,
}