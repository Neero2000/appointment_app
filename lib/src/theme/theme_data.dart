import '../config/index.dart';

class AppTheme {
  static final AppTheme _theme = AppTheme._internal();
  factory AppTheme() {
    return _theme;
  }
  AppTheme._internal();

  static const Color primaryColor = Color(0xFF1C2A3A);
  static const Color successGreen = Color(0xFF009944);
  static const Color errorRed = Color(0xFFcf000f);

  /// other
  final AppBarTheme _appBarTheme = const AppBarTheme(
    backgroundColor: Colors.white,
    actionsIconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
  );

  final ColorScheme _colorScheme = const ColorScheme(
    primary: Colors.black,
    secondary: Colors.black,
    surface: Colors.black,
    background: Colors.black,
    error: Colors.black,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.black,
    brightness: Brightness.light,
  );

  final TextTheme _textTheme = const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  );

  final PageTransitionsTheme _pageTransitionsTheme = const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: _CustomTransition(),
      TargetPlatform.iOS: _CustomTransition(),
    },
  );

  ThemeData get themeData => ThemeData(
        colorScheme: _colorScheme,
        appBarTheme: _appBarTheme,
        scaffoldBackgroundColor: Colors.white,
        textTheme: _textTheme,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        pageTransitionsTheme: _pageTransitionsTheme,
      );
}

/// Used by [PageTransitionsTheme] to define a [MaterialPageRoute] page transition animation.
/// Apps can configure the map of builders for [ThemeData.pageTransitionsTheme] to customize the default
/// [MaterialPageRoute] page transition animation for different platforms.
class _CustomTransition extends PageTransitionsBuilder {
  const _CustomTransition();
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
