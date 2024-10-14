// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:news_app_test/features/settings/views/cubit/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(themeMode: false)) {
    _loadThemeMode();
    _loadUserSettings();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('themeData') ?? false;
    emit(state.copyWith(themeMode: isDarkMode));
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final favoriteCategory = prefs.getStringList('favoriteCategory') ?? [''];
    final city = prefs.getString('cityName') ?? '';

    emit(state.copyWith(
        username: username, favoriteCategories: favoriteCategory, city: city));
  }

  Future<void> toggleTheme() async {
    final newThemeMode = !state.themeMode;
    emit(state.copyWith(themeMode: newThemeMode));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('themeData', newThemeMode);
  }

  Future<void> updateUserSettings(
      String username, List<String> favoriteCategory, String city) async {
    emit(state.copyWith(
        username: username, favoriteCategories: favoriteCategory, city: city));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setStringList('favoriteCategory', favoriteCategory);
    await prefs.setString('city', city);
  }
}
