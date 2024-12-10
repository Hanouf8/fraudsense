import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/providers/providers.dart';

void showHintsPopUp(
    {required BuildContext context,
    required WidgetRef ref,
    required LevelModel levelModel,
    required int scenarioIndex,
    required VoidCallback onUnlockHint,
    required VoidCallback onOpenShop}) {
  SoundManager.instance.playSound("popUp");
  int hintsLeft = ref.read(userDataProvider.notifier).hintsLeft();
  bool hintAlreadyUnlocked = ref
      .read(userDataProvider.notifier)
      .isHintUnlocked(levelIndex: levelModel.index, scenarioIndex: scenarioIndex);

  void onShowHintButton() {
    SoundManager.instance.playSound("hintShow");
    onUnlockHint();
    Navigator.of(context).pop();
  }

  void onOpenShopButton() {
    SoundManager.instance.playSound("tab");
    Navigator.of(context).pop();
    onOpenShop();
  }

  RichText contentText() {
    if (hintAlreadyUnlocked) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(text: S.of(context).game_hintsPopUpAlreadyUnlocked),
          ],
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black),
        children: [
          TextSpan(text: "${S.of(context).game_hintsPopUpTitle} "),
          TextSpan(text: "$hintsLeft\n", style: const TextStyle(fontWeight: FontWeight.bold)),
          if (hintsLeft != 0) TextSpan(text: " ${S.of(context).game_hintsPopUpTitle1}"),
        ],
      ),
    );
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(15),
        content: contentText(),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            child: Text(S.of(context).popUpReturn),
            onPressed: () {
              SoundManager.instance.playSound("tab");
              Navigator.of(context).pop();
            },
          ),
          if (hintsLeft != 0 || hintAlreadyUnlocked)
            ElevatedButton(
                onPressed: onShowHintButton, child: Text(S.of(context).game_hintsPopUpShowHint)),
          if (hintsLeft == 0 && !hintAlreadyUnlocked)
            ElevatedButton(
                onPressed: onOpenShopButton, child: Text(S.of(context).game_hintsPopUpBuyHint))
        ],
      );
    },
  ).then((value) => "");
}
