import 'language_details.dart';
class AppLocalization {
  final Map<String, String> languageNames = {
  "en": "English",
  "es": "Español",
  "si": "සිංහල",
  "hi": "हिन्दी",
  "bn": "বাংলা",
};
  final Map<String, Map<String, String>> _localizedValues = {
    'en': en,
    'es': es,
    'si': si,
    'hi': hi,
    'bn': bn,
  };

  String currentLanguage = 'en';

  // Get translated string
  String translate(String key) {
    return _localizedValues[currentLanguage]?[key] ?? key;
  }

  // Change language dynamically
  void changeLanguage(String langCode) {
    currentLanguage = langCode;
  }
  getLanguages() => _localizedValues.keys.toList();
}

// Global instance
final appLocalization = AppLocalization();
