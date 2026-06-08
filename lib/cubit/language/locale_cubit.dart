// lib/cubit/locale_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// locale_cubit.dart
class LocaleCubit extends Cubit<Locale> {
  static const _key = 'selected_locale';

  LocaleCubit() : super(const Locale('en')) {
    _loadLocale(); // called automatically on creation
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key) ?? 'en';
    emit(Locale(code));
  }

  Future<void> setLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
    emit(Locale(code));
  }

  Future<void> toggleLocale() async {
    await setLocale(state.languageCode == 'en' ? 'ar' : 'en');
  }
}
