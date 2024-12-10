import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/cloud/cloud_services.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/core/utils/date_utilities.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/user_data_model.dart';

final isPopUpOnScreenProvider = StateProvider<bool>((ref) => false);

// notifier
class PasswordVisibilityNotifier extends Notifier<bool> {
  void toggle() {
    state = !state;
  }

  void reset() => state = false;

  @override
  bool build() {
    ref.listen(loginSignUpToggleProvider, (previous, next) {
      reset();
    });
    return false;
  }
}

final passwordVisibilityProvider = NotifierProvider<PasswordVisibilityNotifier, bool>(() {
  return PasswordVisibilityNotifier();
});

class LoginSignUpToggleNotifier extends Notifier<bool> {
  void toggle() {
    state = !state;
  }

  void reset() => state = true;

  @override
  bool build() {
    return true;
  }
}

final loginSignUpToggleProvider =
    NotifierProvider<LoginSignUpToggleNotifier, bool>(() => LoginSignUpToggleNotifier());

final firebaseAuthProvider = StateProvider<FirebaseAuth>((ref) {
  final auth = FirebaseAuth.instance;

  auth.authStateChanges().listen((user) {
    if (user == null) {
      ref.read(userDataProvider.notifier).clearUserData();
      print('User is currently signed out!');
    } else {
      ref.read(userDataProvider.notifier).updateToNewUserData(uid: auth.currentUser!.uid);
    }
    ref.read(loginSignUpToggleProvider.notifier).reset();
  });

  return auth;
});

final cloudControllerProvider = StateProvider<CloudController>((ref) {
  CloudServices cloudServices = CloudServices(FirebaseAuth.instance, FirebaseFirestore.instance);
  return CloudController(cloudServices);
});

final homeTabIndexProvider = StateProvider<int>((ref) => 0);

class LanguageNotifier extends Notifier<AppLanguage> {
  void toggle() {
    switch (state) {
      case AppLanguage.en:
        state = AppLanguage.ar;
        break;
      case AppLanguage.ar:
        state = AppLanguage.en;
        break;

      default:
    }

    ref.read(userDataProvider.notifier).updatePreferredAppLanguage(state);
  }

  void setLanguage(AppLanguage language) {
    state = language;
    ref.read(userDataProvider.notifier).updatePreferredAppLanguage(state);
  }

  TextDirection textDirectionFromLang() {
    switch (state) {
      case AppLanguage.en:
        return TextDirection.ltr;
      case AppLanguage.ar:
        return TextDirection.rtl;

      default:
        return TextDirection.ltr;
    }
  }

  @override
  AppLanguage build() {
    return ref.watch(userDataProvider).preferredLanguage;
  }
}

final languageProvider = NotifierProvider<LanguageNotifier, AppLanguage>(LanguageNotifier.new);

final localeProvider = StateProvider<Locale>((ref) {
  AppLanguage language = ref.watch(languageProvider);

  switch (language) {
    case AppLanguage.en:
      return const Locale("en");
    case AppLanguage.ar:
      return const Locale("ar");

    default:
      return const Locale("en");
  }
});

//returns a user data model once the user is logged in
class UserDataNotifier extends Notifier<UserDataModel> {
  int hintsLeft() {
    return state.availableHints;
  }

  int coins() {
    return state.currency;
  }

  bool isHintUnlocked({required int levelIndex, required int scenarioIndex}) {
    if (state.unlockedHints.containsKey(levelIndex) == false) {
      return false;
    }
    if (state.unlockedHints[levelIndex]!.length < scenarioIndex) {
      return false;
    }
    return state.unlockedHints[levelIndex]![scenarioIndex];
  }

  bool? isScenarioAlreadySolved({required int levelIndex, required int scenarioIndex}) {
    if (state.solvedScenarios.containsKey(levelIndex) == false) {
      return null;
    }
    if (state.solvedScenarios[levelIndex]!.length < scenarioIndex) {
      return null;
    }
    return state.solvedScenarios[levelIndex]![scenarioIndex];
  }

  //marks specific scenario's hint as unlocked if the user unlocked it before, so its unlocked automatically when the scenario starts again
  void markHintUnlocked({required LevelModel levelModel, required int scenarioIndex}) {
    //if u do any changes to the cloud data, the changes wont reflect in this current local state until you recall the build method
    Map<int, List<bool>> unlockedHints = Map.from(state.unlockedHints);

    //initialize the list if it doesn't exist
    if (unlockedHints.containsKey(levelModel.index) == false) {
      unlockedHints[levelModel.index] =
          List.generate(levelModel.scenarios.length, (index) => false);
    }

    //reinitialize the list if it is too short or too long
    if (unlockedHints[levelModel.index]!.length != levelModel.scenarios.length) {
      unlockedHints[levelModel.index]!.clear();
      unlockedHints[levelModel.index] =
          List.generate(levelModel.scenarios.length, (index) => false);
    }

    unlockedHints[levelModel.index]![scenarioIndex] = true;

    state = state.copyWith(unlockedHints: unlockedHints);

    syncUserDataToCloud();
  }

  void markScenarioSolved({required LevelModel levelModel, required int scenarioIndex}) {
    //if u do any changes to the cloud data, the changes wont reflect in this current local state until you recall the build method
    Map<int, List<bool?>> solvedScenarios = Map.from(state.solvedScenarios);

    //initialize the list if it doesn't exist
    if (solvedScenarios.containsKey(levelModel.index) == false) {
      solvedScenarios[levelModel.index] =
          List.generate(levelModel.scenarios.length, (index) => null);
    }

    //reinitialize the list if it is too short or too long
    if (solvedScenarios[levelModel.index]!.length != levelModel.scenarios.length) {
      solvedScenarios[levelModel.index]!.clear();
      solvedScenarios[levelModel.index] =
          List.generate(levelModel.scenarios.length, (index) => null);
    }

    solvedScenarios[levelModel.index]![scenarioIndex] = true;

    state = state.copyWith(solvedScenarios: solvedScenarios);

    //don't forget to call syncUserDataToCloud()
  }

  void markScenarioSolveTime(
      {required LevelModel levelModel, required int scenarioIndex, required int solveTime}) {
    //takes a level index and gives a value thats a list of solve times for each scenario in that level
    Map<int, List<int?>> scenarioSolveTimeMap = Map.from(state.solvedTimeForScenarios);

    //initialize the list if it doesn't exist
    if (scenarioSolveTimeMap.containsKey(levelModel.index) == false) {
      scenarioSolveTimeMap[levelModel.index] =
          List.generate(levelModel.scenarios.length, (index) => null);
    }

    //reinitialize the list if it is too short or too long
    if (scenarioSolveTimeMap[levelModel.index]!.length != levelModel.scenarios.length) {
      scenarioSolveTimeMap[levelModel.index]!.clear();
      scenarioSolveTimeMap[levelModel.index] =
          List.generate(levelModel.scenarios.length, (index) => null);
    }

    scenarioSolveTimeMap[levelModel.index]![scenarioIndex] = solveTime;

    state = state.copyWith(solvedTimeForScenarios: scenarioSolveTimeMap);

    //don't forget to call syncUserDataToCloud()
  }

  void markScenarioFail({required LevelModel levelModel, required int scenarioIndex}) {
    //takes a level index and gives a value thats a list of solve times for each scenario in that level
    Map<int, List<int>> scenarioFailMap = Map.from(state.scenariosFails);

    //initialize the list if it doesn't exist
    if (scenarioFailMap.containsKey(levelModel.index) == false) {
      scenarioFailMap[levelModel.index] = List.generate(levelModel.scenarios.length, (index) => 0);
    }

    //reinitialize the list if it is too short or too long
    if (scenarioFailMap[levelModel.index]!.length != levelModel.scenarios.length) {
      scenarioFailMap[levelModel.index]!.clear();
      scenarioFailMap[levelModel.index] = List.generate(levelModel.scenarios.length, (index) => 0);
    }

    scenarioFailMap[levelModel.index]![scenarioIndex] += 1;

    state = state.copyWith(scenariosFails: scenarioFailMap);

    //don't forget to call syncUserDataToCloud()
  }

  void unlockedLevel(int levelIndex) {
    //making sure we aren't setting the unlockedLevels to a smaller index which will lock previously unlocked levels
    if (state.unlockedLevelsIndex > levelIndex) {
      return;
    }

    //updating the data locally
    state = state.copyWith(unlockedLevelsIndex: levelIndex);

    //then syncing the data in the cloud
    syncUserDataToCloud();
  }

  void addHints(int amount) {
    int currentHints = state.availableHints;

    if (currentHints + amount < 0) {
      throw ArgumentError("cannot have negative hints");
    }

    //updating the data locally
    state = state.copyWith(availableHints: currentHints + amount);

    //then syncing the data in the cloud
    syncUserDataToCloud();
  }

  void addScore(int score) {
    if (score < 0) {
      throw ArgumentError("cannot remove negative");
    }
    int currentScore = state.gameScore;

    state = state.copyWith(gameScore: currentScore + score);

    //don't forget to call syncUserDataToCloud()
  }

  void addCoins(int amount) {
    int currentCoins = state.currency;
    if (currentCoins + amount < 0) {
      throw ArgumentError("cannot have negative coins");
    }

    state = state.copyWith(currency: currentCoins + amount);

    //don't forget to call syncUserDataToCloud()
  }

  void increaseStreak() {
    state = state.copyWith(currentStreak: state.currentStreak + 1);

    if (state.longestStreak < state.currentStreak) {
      state = state.copyWith(longestStreak: state.currentStreak);
    }
  }

  void resetStreak() {
    state = state.copyWith(currentStreak: 0);
  }

  void updateLoggedInDays({required String currentDate}) {
    if (state.lastLoggedInDate != currentDate) {
      state = state.copyWith(lastLoggedInDate: currentDate);
      state = state.copyWith(loggedInDays: state.loggedInDays + 1);
      syncUserDataToCloud();
    }
  }

  void updatePreferredAppLanguage(AppLanguage language) {
    state = state.copyWith(preferredLanguage: language);
    syncUserDataToCloud();
  }

  void updateToNewUserData({required String uid}) async {
    print("user logged in, fetching data");

    final Result result = await ref.read(cloudControllerProvider).fetchUserData(userUid: uid);
    if (result.isSuccess) {
      print("successfully fetched user data");
      updateLoggedInDays(currentDate: DateUtilities.getCurrentDate());
      state = result.data;
    } else {
      print("error fetching user data: ${result.error}");
      //do something here to let the user know an error has accrued
    }
  }

  void clearUserData() {
    print("user logged out, clearing data");
    state = UserDataModel.emptyData();
  }

  void syncUserDataToCloud() {
    //check if theres internet connection
    //if not, return to main screen for now, change this later after discussing how this should behave

    if (state.uid.isEmpty) {
      return;
    }
    print("updating user data to cloud");
    try {
      ref.read(cloudControllerProvider).updateUserData(userUid: state.uid, userDataModel: state);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  UserDataModel build() {
    UserDataModel initialData = UserDataModel.emptyData();
    return initialData;
  }
}

final userDataProvider = NotifierProvider<UserDataNotifier, UserDataModel>(UserDataNotifier.new);
