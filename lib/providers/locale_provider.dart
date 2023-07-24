import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale('my', '');
  String _currentLanguage = 'my';

  Locale get locale => _locale;
  String get currentLanguage => _currentLanguage;

  void setLocale(Locale newLocale, String languageString) {
    _locale = newLocale;
    _currentLanguage = languageString;
    notifyListeners();
  }
}
