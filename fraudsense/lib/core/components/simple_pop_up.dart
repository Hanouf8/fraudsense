import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/providers/providers.dart';

void simplePopUp(
    {required String message,
    required BuildContext? context,
    required WidgetRef? ref}) {
  if (ref == null && context == null) return;

  final isDialogShowing = ref?.read(isPopUpOnScreenProvider.notifier).state;

  // if
  if (isDialogShowing == true) return;

  ref?.read(isPopUpOnScreenProvider.notifier).state = true;

  SoundManager.instance.playSound("popUp");

  showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(15),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  ).then((value) => ref?.read(isPopUpOnScreenProvider.notifier).state = false);
}
