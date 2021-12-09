import 'package:daily_client/src/application.dart';

class ThemeService {
  ThemeService._();
  static final _instance = ThemeService._();
  factory ThemeService.getInstance() => _instance;
  //--------------------

  final _prefService = PrefService.getInstance();
  final _darkTheme = ThemeData.dark().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
  final _lightTheme = ThemeData.light().copyWith(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black54.withOpacity(0),
    ),
    colorScheme: const ColorScheme.light().copyWith(primary: lightBlack),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  late ThemeData theme =
      _prefService.getIsDarkTheme() ? _darkTheme : _lightTheme;
}
