import 'package:flutter/material.dart';

class PopUpButton {
  final String title;
  final VoidCallback onClick;
  final bool isHighlighted;
  final Color? highLightColor;
  final bool isDisabled;

  PopUpButton(
      {required this.title,
      required this.onClick,
      required this.isHighlighted,
      this.highLightColor,
      this.isDisabled = false});
}
