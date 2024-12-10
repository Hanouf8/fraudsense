// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) {
  //this is temporary fix for the language issue, it will be fixed in the database
  if (json['preferredLanguage'] != 'en' && json['preferredLanguage'] != 'ar') {
    json['preferredLanguage'] = 'en';
  }

  return UserDataModel(
    uid: json['uid'] as String,
    userName: json['userName'] as String,
    email: json['email'] as String,
    surName: json['surName'] as String,
    preferredLanguage:
        $enumDecodeNullable(_$AppLanguageEnumMap, json['preferredLanguage']) ?? AppLanguage.en,
    unlockedLevelsIndex: (json['unlockedLevelsIndex'] as num?)?.toInt() ?? 0,
    availableHints: (json['availableHints'] as num?)?.toInt() ?? 3,
    unlockedHints: (json['unlockedHints'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(int.parse(k), (e as List<dynamic>).map((e) => e as bool).toList()),
        ) ??
        {},
    solvedScenarios: (json['solvedScenarios'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(int.parse(k), (e as List<dynamic>).map((e) => e as bool?).toList()),
        ) ??
        {},
    currency: (json['currency'] as num?)?.toInt() ?? 0,
    gameScore: (json['gameScore'] as num?)?.toInt() ?? 0,
    lastLoggedInDate: json['lastLoggedInDate'] as String? ?? '',
    loggedInDays: (json['loggedInDays'] as num?)?.toInt() ?? 0,
    correctAnswersSolved: (json['correctAnswersSolved'] as num?)?.toInt() ?? 0,
    wrongAnswersSolved: (json['wrongAnswersSolved'] as num?)?.toInt() ?? 0,
    currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
    longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
    solvedTimeForScenarios: (json['solvedTimeForScenarios'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(
              int.parse(k), (e as List<dynamic>).map((e) => (e as num?)?.toInt()).toList()),
        ) ??
        {},
    scenariosFails: (json['scenariosFails'] as Map<String, dynamic>?)?.map(
          (k, e) =>
              MapEntry(int.parse(k), (e as List<dynamic>).map((e) => (e as num).toInt()).toList()),
        ) ??
        {},
  );
}

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'userName': instance.userName,
      'email': instance.email,
      'surName': instance.surName,
      'preferredLanguage': _$AppLanguageEnumMap[instance.preferredLanguage]!,
      'unlockedLevelsIndex': instance.unlockedLevelsIndex,
      'availableHints': instance.availableHints,
      'unlockedHints': instance.unlockedHints.map((k, e) => MapEntry(k.toString(), e)),
      'solvedScenarios': instance.solvedScenarios.map((k, e) => MapEntry(k.toString(), e)),
      'currency': instance.currency,
      'gameScore': instance.gameScore,
      'lastLoggedInDate': instance.lastLoggedInDate,
      'loggedInDays': instance.loggedInDays,
      'correctAnswersSolved': instance.correctAnswersSolved,
      'wrongAnswersSolved': instance.wrongAnswersSolved,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'solvedTimeForScenarios':
          instance.solvedTimeForScenarios.map((k, e) => MapEntry(k.toString(), e)),
      'scenariosFails': instance.scenariosFails.map((k, e) => MapEntry(k.toString(), e)),
    };

const _$AppLanguageEnumMap = {
  AppLanguage.ar: 'ar',
  AppLanguage.en: 'en',
};
