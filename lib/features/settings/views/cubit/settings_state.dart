import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool themeMode;
  final String username;
  final List<String>? favoriteCategories; // Change to List<String>
  final String city;

  SettingsState({
    required this.themeMode,
    this.username = '',
    List<String>? favoriteCategories, // Change to List<String>
    this.city = '',
  }) : favoriteCategories = favoriteCategories ?? [''];

  SettingsState copyWith({
    bool? themeMode,
    String? username,
    List<String>? favoriteCategories, // Change to List<String>
    String? city,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      username: username ?? this.username,
      favoriteCategories: favoriteCategories ??
          this.favoriteCategories, // Update to use List<String>
      city: city ?? this.city,
    );
  }

  @override
  List<Object?> get props =>
      [themeMode, username, favoriteCategories, city]; // Update to Object?
}
