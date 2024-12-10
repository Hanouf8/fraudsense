import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/game/scenario_components/coins_display.dart';
import 'package:fraudsense/game/scenario_components/two_options_pop_up.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/pop_up_button_model.dart';
import 'package:fraudsense/providers/providers.dart';

void showShopPopUp(
    {required BuildContext context,
    required WidgetRef ref,
    required VoidCallback onReturn,
    required VoidCallback onBuy,
    required int price}) {
  bool hasEnoughCoins() {
    return ref.watch(userDataProvider).currency > price;
  }

  void onBuyHintButton() {
    SoundManager.instance.playSound("tab1");
    onBuy();
  }

  String message(int coins) {
    if (!hasEnoughCoins()) {
      return S.of(context).shopPopUp_cantBuy;
    }
    return S.of(context).shopPopUp_canBuy;
  }

  Widget content() {
    return Consumer(builder: (context, ref, child) {
      int coins = ref.watch(userDataProvider).currency;

      return SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                coinsDisplay(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message(coins))
          ],
        ),
      );
    });
  }

  twoOptionsPopUp(
      canPopOut: false,
      context: context,
      message: "",
      content: content(),
      leftOption: PopUpButton(
        title: S.of(context).popUpReturn,
        onClick: () {
          Navigator.of(context).pop();
          onReturn();
        },
        isHighlighted: false,
      ),
      rightOption: PopUpButton(
          title: S.of(context).popUpConfirm,
          onClick: onBuyHintButton,
          isHighlighted: true,
          isDisabled: !hasEnoughCoins()),
      barrierDismissible: false,
      blurBackground: true);
}
