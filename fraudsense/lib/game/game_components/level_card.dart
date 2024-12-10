import 'package:flutter/material.dart';
import 'package:fraudsense/core/language/language_manager.dart';
import 'package:fraudsense/game/scenario_components/two_options_pop_up.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/pop_up_button_model.dart';

class LevelCard extends StatelessWidget {
  const LevelCard(
      {super.key,
      required this.onStart,
      required this.levelIndex,
      required this.unlocked,
      required this.description});

  final VoidCallback onStart;
  final int levelIndex;
  final bool unlocked;
  final String description;

  @override
  Widget build(BuildContext context) {
    String popUpText = unlocked
        ? "${S.of(context).levelsTab_levelPopUpSelectedLevel}: $levelIndex"
        : S.of(context).levelsTab_levelPopUpLockedLevel;

    void onClick() {
      twoOptionsPopUp(
          context: context,
          message: popUpText,
          leftOption: PopUpButton(
              title: S.of(context).popUpReturn,
              onClick: () {
                Navigator.pop(context);
              },
              isHighlighted: false),
          rightOption: PopUpButton(
              title: S.of(context).levelsTab_levelPopUpStartLevel,
              onClick: () {
                if (unlocked) onStart();
              },
              isHighlighted: true,
              highLightColor: unlocked ? Colors.green.shade100 : Colors.grey.shade800),
          barrierDismissible: true,
          blurBackground: false,
          canPopOut: false);
    }

    Color textColor = unlocked ? Colors.black : Colors.grey;
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 10.0) + const EdgeInsets.symmetric(horizontal: 10),
      // padding: EdgeInsets,
      child: SizedBox(
        height: 100,
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: unlocked ? Colors.green[100] : Colors.grey.shade700),
            child: Stack(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 40,
                        child: Center(
                          child: Text(
                            levelIndex.toString(),
                            style: TextStyle(fontSize: 25, color: textColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 200,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withAlpha(100),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(textAlign: TextAlign.center, description),
                            )),
                          ),
                        )),
                  ),
                ],
              ),
              if (!unlocked)
                Align(
                  alignment: LanguageManager.isDirectionRTL(context) == TextDirection.rtl
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  child: CircleAvatar(
                      maxRadius: 17,
                      backgroundColor: Colors.grey.shade700,
                      child: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      )),
                )
            ]),
          ),
        ),
      ),
    );
  }
}
