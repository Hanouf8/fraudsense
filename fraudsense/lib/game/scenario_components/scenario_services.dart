//This is the services layer for the scenario controller, basically it will handle all operations that need
//a BuildContext or WidgetRef, this makes it possible to mock without actually using either of them
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/game/levels/level_manger.dart';
import 'package:fraudsense/game/scenario_components/character_dialogue_box.dart';
import 'package:fraudsense/game/scenario_components/two_options_pop_up.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/pop_up_button_model.dart';

class ScenarioServices {
  final BuildContext context;
  final WidgetRef ref;

  ScenarioServices({required this.context, required this.ref});

  String rightAnswerMessage(int solveTime) =>
      "${S.of(context).game_rightAnswer} $solveTime ${S.of(context).game_rightAnswer1}!";

  String get wrongAnswerMessage => S.of(context).game_wrongAnswer;

  String get scenarioAlreadyFinishedMessage => S.of(context).game_popUpAlreadyFinishedScenario;

  void displayTimerPopUp() {
    twoOptionsPopUp(
      context: context,
      message: S.of(context).game_popUpTimeRanOutTitle,
      //shows the quit button
      leftOption: PopUpButton(
          title: S.of(context).game_popUpQuit,
          onClick: () {
            LevelManger.instance.quitLevel(context: context, ref: ref);
          },
          isHighlighted: true,
          highLightColor: Colors.red),
      //shows the next scenario button
      rightOption: PopUpButton(
          title: S.of(context).game_popUpNextScenario,
          onClick: () {
            LevelManger.instance.nextScenario(context: context, ref: ref);
          },
          isHighlighted: true),
      barrierDismissible: false,
      blurBackground: true,
      canPopOut: false,
    );
  }

  void displayScenarioIsOverPopUp({
    required String message,
    bool canPopOut = true,
  }) {
    twoOptionsPopUp(
        context: context,
        message: message,
        leftOption: PopUpButton(
            title: S.of(context).game_popUpReturnToGame,
            onClick: () {},
            isHighlighted: false,
            isDisabled: !canPopOut),
        rightOption: PopUpButton(
          title: S.of(context).game_popUpNextScenario,
          onClick: () {
            LevelManger.instance.nextScenario(context: context, ref: ref);
          },
          isHighlighted: true,
        ),
        barrierDismissible: canPopOut,
        blurBackground: true,
        canPopOut: canPopOut);
  }

  void displayStartingCharacterMessage(
      {required VoidCallback onExit,
      required TextDirection textDirection,
      required String fullDialogueText}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Colors.black54.withAlpha(0),
            contentPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            content: CharacterDialogueBox(
              textDirection: textDirection,
              fullDialogueText: fullDialogueText,
              maxTextLengthPerSlide: 150,
              onExit: () {
                Navigator.pop(context);
                onExit();
              },
            ),
          ),
        );
      },
    );
  }

  void displayPauseGamePopUp({required VoidCallback onReturn, required VoidCallback onQuit}) {
    //shows a pop up that confirms if the user wants to quit, the passed onQuit function
    //will be called on the new popup asking the user to confirm the quit
    twoOptionsPopUp(
        context: context,
        message: S.of(context).game_popUpPauseTitle,
        leftOption:
            PopUpButton(title: S.of(context).popUpReturn, onClick: onReturn, isHighlighted: false),
        rightOption: PopUpButton(
            title: S.of(context).game_popUpQuit,
            onClick: () => displayConfirmQuitPopUp(onReturn: onReturn, onQuit: onQuit),
            isHighlighted: true,
            highLightColor: Colors.red),
        barrierDismissible: false,
        blurBackground: true);
  }

  void displayConfirmQuitPopUp({required VoidCallback onReturn, required VoidCallback onQuit}) {
    twoOptionsPopUp(
        context: context,
        message: S.of(context).game_confirmQuit,
        leftOption:
            PopUpButton(title: S.of(context).popUpReturn, onClick: onReturn, isHighlighted: false),
        rightOption: PopUpButton(
          title: S.of(context).popUpConfirm,
          onClick: onQuit,
          isHighlighted: true,
        ),
        barrierDismissible: false,
        blurBackground: true);
  }

  void quitLevel() {
    LevelManger.instance.quitLevel(context: context, ref: ref);
  }
}
