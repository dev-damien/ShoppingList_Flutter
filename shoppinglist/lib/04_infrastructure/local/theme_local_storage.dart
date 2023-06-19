import 'package:shared_preferences/shared_preferences.dart';

const CACHED_THEME_MODE = 'CACHED_THEME_MODE';

const CACHED_USE_SYSTEM_THEME = 'CACHED_USE_SYSTEM_THEME';

const DEFAULT_THEME = "light";

//! possibility to add more themes
const supportedThemes = [
  "light",
  "dark",
];

abstract class ThemeLocalDatasource {
  Future<String> getCachedThemeData();
  Future<bool> getUseSystemTheme();

  Future<void> cacheThemeData({required String theme});
  Future<void> cacheUseSystemTheme({required bool useSystemTheme});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  final SharedPreferences sharedPreferences;
  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheThemeData({required String theme}) {
    return sharedPreferences.setString(CACHED_THEME_MODE, theme);
  }

  @override
  Future<String> getCachedThemeData() {
    final theme = sharedPreferences.getString(CACHED_THEME_MODE);

    if (theme != null && supportedThemes.contains(theme)) {
      return Future.value(theme);
    }
    return Future.value(DEFAULT_THEME);
  }

  @override
  Future<void> cacheUseSystemTheme({required bool useSystemTheme}) {
    return sharedPreferences.setBool(CACHED_USE_SYSTEM_THEME, useSystemTheme);
  }

  @override
  Future<bool> getUseSystemTheme() {
    final useSystemTheme = sharedPreferences.getBool(CACHED_USE_SYSTEM_THEME);

    if (useSystemTheme != null) {
      return Future.value(useSystemTheme);
    }
    return Future.value(true);
  }
}
