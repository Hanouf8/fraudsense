import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/utils/timer.dart';
import 'package:fraudsense/game/scenario_components/scenario_services.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/models/answer_model.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/mistake_model.dart';
import 'package:fraudsense/models/scenario_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';

//this gives the scenario a controller to interact with the game
class ScenarioController {
  final ScenarioModel targetScenario;
  final int scenarioIndex;
  final LevelModel parent;
  final bool? currentScenarioIsAlreadySolved;
  final TextDirection textDirection;

  bool gamePaused = false;
  bool scenarioIsOver = false;

  final SoundManager soundManager;
  final ScenarioServices scenarioServices;
  final WidgetRef ref;
  // final ProviderContainer ref;

  late final TimerController timerController;

  //initialize the scenario controller
  ScenarioController(
      {required this.targetScenario,
      required this.textDirection,
      required this.parent,
      required this.scenarioIndex,
      required this.currentScenarioIsAlreadySolved,
      required this.soundManager,
      required this.scenarioServices,
      required this.ref}) {
    timerController = TimerController(
        initialDuration: Duration(seconds: targetScenario.timeToSolveInSeconds),
        onTick: onTimerTick);
    soundManager.playBackgroundAudio();
    showStartingCharacterMessage(targetScenario.startingCharacterMessage);
  }

  void onTimerTick() {
    soundManager.playSound("tick");
    ref.read(timerValueProvider.notifier).state = timerController.currentDurationLeft.inSeconds;

    if (timerController.currentDurationLeft.inSeconds == 0) {
      timeRanOut();
    }
  }

  void quitLevel() {
    soundManager.endBackgroundAudio();
    scenarioServices.quitLevel();
  }

  void pauseGame() {
    gamePaused = true;
    timerController.pauseTimer(true);
  }

  void unpauseGame() {
    gamePaused = false;
    timerController.pauseTimer(false);
  }

  void submitAnswer(AnswerModel answerModel) {
    if (gamePaused || scenarioIsOver) return;
    pauseGame();

    if (answerModel.isCorrect) {
      soundManager.playSound("rightAnswer");

      ref.read(submittedAnswerProvider.notifier).state = true;

      //run this before markCurrentScenarioSolved() to make sure it gives score to an unmarked scenario
      giveScoreAndCoins(ref: ref);
      increaseStreak(ref: ref);
      markCurrentScenarioSolved(ref: ref);

      int solveTime =
          targetScenario.timeToSolveInSeconds - timerController.currentDurationLeft.inSeconds;

      markScenarioSolveTime(ref: ref, solveTime: solveTime);

      endScenario(
          delay: Durations.extralong4,
          message: scenarioServices.rightAnswerMessage(solveTime),
          canPopOut: true);
    } else {
      soundManager.playSound("wrongAnswer");

      ref.read(submittedAnswerProvider.notifier).state = false;
      ref.read(unsolvedScenariosListProvider.notifier).addScenario(
          UnsolvedScenariosModel(pickedAnswer: answerModel, scenarioModel: targetScenario));

      markScenarioFail(ref: ref);
      resetStreak(ref: ref);

      endScenario(
        delay: Durations.extralong4,
        message: scenarioServices.wrongAnswerMessage,
        canPopOut: false,
      );
    }
    syncUserDataToCloud(ref: ref);
    //play a little animation if its right or wrong
  }

  void timeRanOut() {
    scenarioIsOver = true;
    resetStreak(ref: ref);
    markScenarioFail(ref: ref);

    ref
        .read(unsolvedScenariosListProvider.notifier)
        .addScenario(UnsolvedScenariosModel(pickedAnswer: null, scenarioModel: targetScenario));

    //shows a pop up that locks the user in the scenario until they pick a choice
    Future.delayed(Durations.extralong4, () {
      scenarioServices.displayTimerPopUp();
    });
  }

  void endScenario({
    required Duration delay,
    required String message,
    bool canPopOut = true,
  }) {
    scenarioIsOver = true;
    soundManager.endBackgroundAudio();

    Future.delayed(
      delay,
      () {
        scenarioServices.displayScenarioIsOverPopUp(message: message, canPopOut: canPopOut);
      },
    );
  }

  void showStartingCharacterMessage(String message) {
    if (message.trim().isEmpty) return;
    pauseGame();

    Future.delayed(Duration.zero, () {
      soundManager.playSound("hintShow");

      scenarioServices.displayStartingCharacterMessage(
        onExit: unpauseGame,
        textDirection: textDirection,
        fullDialogueText: targetScenario.startingCharacterMessage,
      );
    });
  }

//simply calls the pause game pop up or the game over pop up
  void onPauseButtonClick() {
    if (scenarioIsOver) {
      scenarioServices.displayScenarioIsOverPopUp(
        message: scenarioServices.scenarioAlreadyFinishedMessage,
      );
    } else {
      if (gamePaused) return;
      pauseGame();
      scenarioServices.displayPauseGamePopUp(
        onReturn: unpauseGame,
        onQuit: () {
          quitLevel();
        },
      );
    }
  }

  void unlockCurrentHint() {
    ref.read(displayCurrentHintProvider.notifier).state = true;

    bool hintAlreadyUnlocked = ref
        .read(userDataProvider.notifier)
        .isHintUnlocked(levelIndex: parent.index, scenarioIndex: scenarioIndex);

    if (!hintAlreadyUnlocked) {
      ref.read(userDataProvider.notifier).addHints(-1);
      ref.read(userDataProvider.notifier).markHintUnlocked(
            levelModel: parent,
            scenarioIndex: scenarioIndex,
          );
    }
  }

  void buyHint(int price) {
    print(
        " $price is the price, current currency is ${ref.read(userDataProvider.notifier).coins()}");
    if (ref.read(userDataProvider.notifier).coins() < price) return;

    ref.read(userDataProvider.notifier).addCoins(-price);
    ref.read(userDataProvider.notifier).addHints(1);
  }

  void giveScoreAndCoins({required WidgetRef ref}) {
    //gives the score and the coins to the user if its their first time solving the scenario

    if (currentScenarioIsAlreadySolved != null && currentScenarioIsAlreadySolved!) {
      return;
    }

    print("adding score and coins");
    ref.read(userDataProvider.notifier).addScore(targetScenario.scoreGainedOnCompletion);
    ref.read(userDataProvider.notifier).addCoins(5 * parent.index);
  }

  void markCurrentScenarioSolved({required WidgetRef ref}) {
    ref
        .read(userDataProvider.notifier)
        .markScenarioSolved(levelModel: parent, scenarioIndex: scenarioIndex);
  }

  void markCurrentScenarioHintUnlocked({required WidgetRef ref}) {
    ref
        .read(userDataProvider.notifier)
        .markHintUnlocked(levelModel: parent, scenarioIndex: scenarioIndex);
  }

  bool isCurrentScenarioHintUnlocked({required WidgetRef ref}) {
    return ref
        .read(userDataProvider.notifier)
        .isHintUnlocked(levelIndex: parent.index, scenarioIndex: scenarioIndex);
  }

  void increaseStreak({required WidgetRef ref}) {
    ref.read(userDataProvider.notifier).increaseStreak();
  }

  void resetStreak({required WidgetRef ref}) {
    ref.read(userDataProvider.notifier).resetStreak();
  }

  void markScenarioSolveTime({required WidgetRef ref, required int solveTime}) {
    ref.read(userDataProvider.notifier).markScenarioSolveTime(
        levelModel: parent, scenarioIndex: scenarioIndex, solveTime: solveTime);
  }

  void markScenarioFail({required WidgetRef ref}) {
    ref
        .read(userDataProvider.notifier)
        .markScenarioFail(levelModel: parent, scenarioIndex: scenarioIndex);
  }

  void syncUserDataToCloud({required WidgetRef ref}) {
    ref.read(userDataProvider.notifier).syncUserDataToCloud();
  }
}
