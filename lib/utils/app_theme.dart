import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/services/storage/storage_services.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to manage app theme (Light / Dark mode) with persistence
class ThemeCubit extends Cubit<ThemeMode> {
  final StorageServices _storageServices = StorageServices.instance;

  ThemeCubit() : super(ThemeMode.light) {
    _init();
  }

  Future<void> _init() async {
    try {
      final isDark = await _storageServices.isDarkMode();
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    } catch (e) {
      errorLog("_init ThemeCubit", e);
    }
  }

  void toggleTheme() {
    try {
      if (state == ThemeMode.light) {
        emit(ThemeMode.dark);
        _storageServices.setDarkMode(true);
      } else {
        emit(ThemeMode.light);
        _storageServices.setDarkMode(false);
      }
    } catch (e) {
      errorLog("toggleTheme ThemeCubit", e);
    }
  }

  void setTheme(ThemeMode mode) {
    emit(mode);
    _storageServices.setDarkMode(mode == ThemeMode.dark);
  }
}
