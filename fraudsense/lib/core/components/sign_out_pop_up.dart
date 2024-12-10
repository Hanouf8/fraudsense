import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/game/scenario_components/two_options_pop_up.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/pop_up_button_model.dart';

void signOutPopUp({required BuildContext context}) {
  twoOptionsPopUp(
      context: context,
      message: S.of(context).signOutButton_PopUpTitle,
      leftOption: PopUpButton(
          highLightColor: Colors.red.shade300,
          title: S.of(context).popUpConfirm,
          onClick: () {
            FirebaseAuth.instance.signOut();
          },
          isHighlighted: true),
      rightOption:
          PopUpButton(title: S.of(context).popUpReturn, onClick: () {}, isHighlighted: false),
      barrierDismissible: true,
      blurBackground: false);
}
