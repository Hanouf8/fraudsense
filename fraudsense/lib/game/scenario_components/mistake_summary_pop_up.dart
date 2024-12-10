
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/game/scenario_components/fake_mobile_screen.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/mistake_model.dart';

void mistakeSummaryPopUp(
    {required BuildContext context,
    required UnsolvedScenariosModel scenarioSolvedIncorrectly,
    required VoidCallback onNext,
    required TextDirection textDirection}) {
  Widget characterImage() {
    return Transform.flip(
      child: Image.asset(
        'assets/images/character/character_think.png',
      ),
    );
  }

  SoundManager.instance.playSound("popUp");

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        // contentPadding: EdgeInsets.zero,
        actionsPadding: const EdgeInsets.all(15),
        // buttonPadding: EdgeInsets.zero,
        // backgroundColor: Colors.,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,

        content: SizedBox(
          height: 500,
          child: Column(
            children: [
              const VerticalSpace(height: 0.04),
              FakeMobileScreen(
                contactTitle: scenarioSolvedIncorrectly.scenarioModel.contactTitle,
                receivedMessage: scenarioSolvedIncorrectly.scenarioModel.receivedMessage,
                receivedLink: scenarioSolvedIncorrectly.scenarioModel.receivedLink,
                isVerifiedContact: scenarioSolvedIncorrectly.scenarioModel.isVerifiedContact,
                messageTime: scenarioSolvedIncorrectly.scenarioModel.messageTime,
                textDirection: textDirection,
                disableUnnecessaryIcons: true,
              ),
              const VerticalSpace(height: 0.02),
              const Divider(),
              const VerticalSpace(height: 0.00),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${S.of(context).game_mistakeSummaryPickedAnswer}:"),
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                textDirection: textDirection,
                                textAlign: TextAlign.center,
                                scenarioSolvedIncorrectly.pickedAnswer!.text,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(height: 80, child: characterImage()),
                      ),
                    ],
                  ),
                  const VerticalSpace(height: 0.01),
                  Column(
                    children: [
                      Text("${S.of(context).game_mistakeSummaryExplanation}:"),
                      SizedBox(
                        width: 300,
                        height: 80,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.red.shade100, borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: AutoSizeText(
                              textDirection: textDirection,
                              textAlign: TextAlign.center,
                              maxFontSize: 20,
                              minFontSize: 12,
                              maxLines: 5,
                              scenarioSolvedIncorrectly.pickedAnswer!.explanationWhenIncorrect,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const VerticalSpace(height: 0.01),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Container(),
          Consumer(builder: (context, ref, child) {
            return ElevatedButton(
              onPressed: onNext,
              child: Text(S.of(context).game_popUpNext),
            );
          })
        ],
      );
    },
  ).then((value) => "");
}
