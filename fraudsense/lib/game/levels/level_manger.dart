import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/language/language_manager.dart';
import 'package:fraudsense/game/scenario_components/mistake_summary_pop_up.dart';
import 'package:fraudsense/game/scenario_components/two_options_pop_up.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/mistake_model.dart';
import 'package:fraudsense/models/pop_up_button_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/game%20screens/scenario_screen.dart';
import 'package:fraudsense/screens/root_screen.dart';

class LevelManger {
  LevelModel? currentLevel;
  int scenarioIndex = 0;

  LevelManger.levelMangerConstructor();

  static final LevelManger instance = LevelManger.levelMangerConstructor();

  void _resetGameProviders(ref) {
    ref.read(selectedAnswerProvider.notifier).state = null;
    ref.read(submittedAnswerProvider.notifier).state = null;
    ref.read(displayCurrentHintProvider.notifier).state = false;
  }

  void startLevel(
      {required BuildContext context, required WidgetRef ref, required LevelModel levelModel}) {
    currentLevel = levelModel;

    _resetGameProviders(ref);

    startScenario(context: context, ref: ref, scenarioIndex: 0);
  }

  void nextScenario({required BuildContext context, required WidgetRef ref}) {
    if (currentLevel == null) return;
    scenarioIndex++;

    if (currentLevel!.scenarios.length <= scenarioIndex) {
      //finish level when we reach the end of the scenarios
      _finishLevel(context: context, ref: ref);

      return;
    }
    _resetGameProviders(ref);

    startScenario(context: context, scenarioIndex: scenarioIndex, ref: ref);
  }

  void startScenario(
      {required BuildContext context, required WidgetRef ref, required int scenarioIndex}) {
    ref.read(timerValueProvider.notifier).state =
        currentLevel!.scenarios[scenarioIndex].timeToSolveInSeconds;
    _goToNewScreen(
      context: context,
      screen: ScenarioScreen(
        scenarioModel: currentLevel!.scenarios[scenarioIndex],
        textDirection: LanguageManager.isDirectionRTL(context),
        parent: currentLevel!,
        index: scenarioIndex,
      ),
    );
  }

  void _finishLevel({required BuildContext context, required WidgetRef ref}) {
    // int totalQuestions = currentLevel!.scenarios.length;
    int totalUnsolvedScenarios = ref.read(unsolvedScenariosListProvider).length;
    int totalIncorrectlySolvedScenarios =
        ref.read(unsolvedScenariosListProvider.notifier).scenariosSolvedIncorrectly().length;

    int totalScenarios = currentLevel!.scenarios.length;
    int totalSolvedScenarios = totalScenarios - totalUnsolvedScenarios;

    String popUpText = totalSolvedScenarios == 0
        ? S.of(context).game_endPopUpTitleAllWrong
        : "${S.of(context).game_endPopUpTitle} $totalSolvedScenarios ${S.of(context).game_endPopUpTitle1} $totalScenarios!";

    //this means the user finished the whole level with no mistakes
    if (totalUnsolvedScenarios == 0) {
      //currentLevel!.index starts at 1

      //if its our first time solving this level
      if (!(ref.read(userDataProvider).unlockedLevelsIndex > currentLevel!.index - 1)) {
        //setting this level to be completed thus unlocking the next one
        ref.read(userDataProvider.notifier).unlockedLevel(currentLevel!.index);
      }
    }
    //if the user has made a mistake solving a previous scenario, a button will appear that shows him the mistakes he did, then it displays what he picked wrong and why it was wrong
    twoOptionsPopUp(
        context: context,
        message: popUpText,
        leftOption: PopUpButton(
            title: S.of(context).game_popUpViewMistakes,
            onClick: () {
              _viewMistakes(context: context, ref: ref);
            },
            isHighlighted: true,
            highLightColor: Colors.red.shade300,
            isDisabled: totalIncorrectlySolvedScenarios == 0),
        rightOption: PopUpButton(
            title: S.of(context).game_popUpExit,
            onClick: () {
              quitLevel(context: context, ref: ref);
            },
            isHighlighted: true,
            highLightColor: Colors.green.shade200),
        barrierDismissible: false,
        blurBackground: true,
        canPopOut: false);
  }

  void _viewMistakes({required BuildContext context, required WidgetRef ref}) {
    List<UnsolvedScenariosModel> scenariosSolvedIncorrectly =
        ref.read(unsolvedScenariosListProvider.notifier).scenariosSolvedIncorrectly();

    if (scenariosSolvedIncorrectly.isEmpty) return;

    int mistakeIndex = 0;
    void displayPopUp() {
      mistakeSummaryPopUp(
          context: context,
          scenarioSolvedIncorrectly: scenariosSolvedIncorrectly[mistakeIndex],
          onNext: () {
            SoundManager.instance.playSound("tab");

            mistakeIndex++;

            if (mistakeIndex >= scenariosSolvedIncorrectly.length) {
              Navigator.of(context).pop();
              return;
            }

            Navigator.of(context).pop();
            displayPopUp();
          },
          textDirection: LanguageManager.isDirectionRTL(context));
    }

    displayPopUp();
  }

  void quitLevel({required BuildContext context, required WidgetRef ref}) {
    currentLevel = null;
    scenarioIndex = 0;
    _resetGameProviders(ref);

    //resetting the picked wrong answers list
    ref.read(unsolvedScenariosListProvider.notifier).rest();

    ref.read(homeTabIndexProvider.notifier).state = 1;
    _goToNewScreen(context: context, screen: const RootScreen());
  }

  void _goToNewScreen({required BuildContext context, required Widget screen}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
  }
}
