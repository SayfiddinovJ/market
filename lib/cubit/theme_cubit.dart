import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/data/storage/storage_repository.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  static const _key = 'theme_mode';

  Future<void> loadTheme() async {
    final themeStr = StorageRepository.getString(_key);
    debugPrint('themeStr: $themeStr');

    switch (themeStr) {
      case 'light':
        emit(ThemeMode.light);
        break;
      case 'dark':
        emit(ThemeMode.dark);
        break;

    }
  }

  void setLightTheme() async {
    emit(ThemeMode.light);
    await StorageRepository.putString(_key, 'light');
  }

  void setDarkTheme() async {
    emit(ThemeMode.dark);
    await StorageRepository.putString(_key, 'dark');
  }
}
