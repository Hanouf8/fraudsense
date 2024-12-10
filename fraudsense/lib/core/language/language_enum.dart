enum AppLanguage { ar, en }

const appLanguageValues = {
  'ar': AppLanguage.ar,
  'en': AppLanguage.en,
};

AppLanguage appLanguageFromJson(String json) => appLanguageValues[json]!;
String appLanguageToJson(AppLanguage language) =>
    appLanguageValues.keys.firstWhere((k) => appLanguageValues[k] == language);
