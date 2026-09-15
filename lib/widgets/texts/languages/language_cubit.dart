import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Cubit to manage current language locale code (e.g. "en_US") with persistence
class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super("en_US") {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("app_language") ?? "en_US";
    emit(saved);
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("app_language", lang);
    emit(lang);
  }
}
