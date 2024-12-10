import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/models/pop_up_button_model.dart';

void twoOptionsPopUp(
    {required context,
    required String message,
    required PopUpButton leftOption,
    required PopUpButton rightOption,
    required bool barrierDismissible,
    required bool blurBackground,
    Widget? content,
    bool canPopOut = true,
    bool playSounds = true}) {
  if (playSounds) SoundManager.instance.playSound("popUp");

  Widget button(PopUpButton buttonData) {
    if (!buttonData.isHighlighted) {
      return TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              buttonData.isDisabled ? Colors.grey.shade700.withAlpha(50) : Colors.grey.withAlpha(0),
            ),
          ),
          child: Text(buttonData.title),
          onPressed: () {
            if (playSounds) SoundManager.instance.playSound("tab");

            if (canPopOut) {
              Navigator.of(context).pop();
            }
            buttonData.onClick();
          });
    } else {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                buttonData.isDisabled ? Colors.grey.shade700 : buttonData.highLightColor)),
        child: Text(buttonData.title),
        onPressed: () {
          if (playSounds) SoundManager.instance.playSound("tab");

          if (canPopOut) {
            Navigator.of(context).pop();
          }
          buttonData.onClick();
        },
      );
    }
  }

  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      double blurAmount = blurBackground ? 10 : 0;
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: PopScope(
          canPop: false,
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            // actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsPadding: const EdgeInsets.all(15),
            content: content ??
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
            // actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [button(leftOption), button(rightOption)],
          ),
        ),
      );
    },
  ).then((value) => "");
}
