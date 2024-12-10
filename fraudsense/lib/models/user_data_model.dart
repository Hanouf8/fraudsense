import 'package:fraudsense/core/language/language_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/user_data_model.g.dart';

@JsonSerializable()
class UserDataModel {
  final String uid;
  final String userName;
  final String email;
  final String surName;

  @JsonKey(defaultValue: AppLanguage.en)
  final AppLanguage preferredLanguage;

  @JsonKey(defaultValue: 0)
  final int unlockedLevelsIndex;

  @JsonKey(defaultValue: 3)
  final int availableHints;

  @JsonKey(defaultValue: {})
  final Map<int, List<bool>> unlockedHints;

  //this can be false or true or null, its null when its the first time solving that scenario
  @JsonKey(defaultValue: {})
  final Map<int, List<bool?>> solvedScenarios;

  //this annotation is used to make sure if this field is missing from a json file, its then set to a default value
  @JsonKey(defaultValue: 0)
  final int currency;

  @JsonKey(defaultValue: 0)
  final int gameScore;

//info fields for the report generator
  @JsonKey(defaultValue: "")
  final String lastLoggedInDate;

  @JsonKey(defaultValue: 0)
  final int loggedInDays;

  @JsonKey(defaultValue: 0)
  final int correctAnswersSolved;

  @JsonKey(defaultValue: 0)
  final int wrongAnswersSolved;

  @JsonKey(defaultValue: 0)
  final int currentStreak;

  @JsonKey(defaultValue: 0)
  final int longestStreak;

  @JsonKey(defaultValue: {})
  final Map<int, List<int?>> solvedTimeForScenarios;

  @JsonKey(defaultValue: {})
  final Map<int, List<int>> scenariosFails;

  const UserDataModel(
      {required this.uid,
      required this.userName,
      required this.email,
      required this.surName,
      required this.preferredLanguage,
      required this.unlockedLevelsIndex,
      required this.availableHints,
      required this.unlockedHints,
      required this.solvedScenarios,
      required this.currency,
      required this.gameScore,
      required this.lastLoggedInDate,
      required this.loggedInDays,
      required this.correctAnswersSolved,
      required this.wrongAnswersSolved,
      required this.currentStreak,
      required this.longestStreak,
      required this.solvedTimeForScenarios,
      required this.scenariosFails});

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

  UserDataModel copyWith(
      {String? uid,
      String? email,
      String? userName,
      String? surName,
      AppLanguage? preferredLanguage,
      int? unlockedLevelsIndex,
      int? availableHints,
      Map<int, List<bool>>? unlockedHints,
      Map<int, List<bool?>>? solvedScenarios,
      int? currency,
      int? gameScore,
      String? lastLoggedInDate,
      int? loggedInDays,
      int? correctAnswersSolved,
      int? wrongAnswersSolved,
      int? currentStreak,
      int? longestStreak,
      Map<int, List<int?>>? solvedTimeForScenarios,
      Map<int, List<int>>? scenariosFails}) {
    return UserDataModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        surName: surName ?? this.surName,
        preferredLanguage: preferredLanguage ?? this.preferredLanguage,
        unlockedLevelsIndex: unlockedLevelsIndex ?? this.unlockedLevelsIndex,
        availableHints: availableHints ?? this.availableHints,
        unlockedHints: unlockedHints ?? this.unlockedHints,
        solvedScenarios: solvedScenarios ?? this.solvedScenarios,
        currency: currency ?? this.currency,
        gameScore: gameScore ?? this.gameScore,
        lastLoggedInDate: lastLoggedInDate ?? this.lastLoggedInDate,
        loggedInDays: loggedInDays ?? this.loggedInDays,
        correctAnswersSolved: correctAnswersSolved ?? this.correctAnswersSolved,
        wrongAnswersSolved: wrongAnswersSolved ?? this.wrongAnswersSolved,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        solvedTimeForScenarios: solvedTimeForScenarios ?? this.solvedTimeForScenarios,
        scenariosFails: scenariosFails ?? this.scenariosFails);
  }

  static UserDataModel emptyData() {
    return const UserDataModel(
        email: "",
        uid: "",
        userName: "",
        surName: "",
        preferredLanguage: AppLanguage.en,
        unlockedLevelsIndex: 0,
        availableHints: 0,
        unlockedHints: {},
        solvedScenarios: {},
        currency: 0,
        gameScore: 0,
        lastLoggedInDate: "",
        loggedInDays: 0,
        correctAnswersSolved: 0,
        wrongAnswersSolved: 0,
        currentStreak: 0,
        longestStreak: 0,
        solvedTimeForScenarios: {},
        scenariosFails: {});
  }
}
