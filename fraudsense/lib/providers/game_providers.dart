import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/game/levels/level_io.dart';
import 'package:fraudsense/models/answer_model.dart';
import 'package:fraudsense/models/levels_holder_model.dart';
import 'package:fraudsense/models/mistake_model.dart';
import 'package:fraudsense/providers/providers.dart';

//this needs to be set true automatically when the user has already unlocked a hint for the scenario
final displayCurrentHintProvider = StateProvider<bool>((ref) => false);

//this updates the timer UI
final timerValueProvider = StateProvider<int>((ref) => 20);

//the current selected answer from the user before submitting
final selectedAnswerProvider = StateProvider.autoDispose<AnswerModel?>((ref) {
  return null;
});

//this bool return true if the selected and submitted answer is correct,
//or false if its not. and if theres no submitted answer yet returns null
final submittedAnswerProvider = StateProvider.autoDispose<bool?>((ref) {
  return null;
});

class UnsolvedScenariosListNotifier extends Notifier<List<UnsolvedScenariosModel>> {
  void addScenario(UnsolvedScenariosModel scenariosModel) {
    state = [...state, scenariosModel];
  }

  //returns a list of all the scenarios that have been solved incorrectly only
  List<UnsolvedScenariosModel> scenariosSolvedIncorrectly() {
    return state.where((unsolvedScenario) => unsolvedScenario.pickedAnswer != null).toList();
  }

  void rest() {
    state = [];
  }

  @override
  List<UnsolvedScenariosModel> build() {
    return [];
  }
}

final unsolvedScenariosListProvider =
    NotifierProvider<UnsolvedScenariosListNotifier, List<UnsolvedScenariosModel>>(
        UnsolvedScenariosListNotifier.new);

final levelsProvider = FutureProvider<LevelsHolderModel>((ref) {
  AppLanguage language = ref.watch(languageProvider);
  return LevelIO.getLocalizedLevels(language);
});
