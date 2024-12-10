import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String text, BuildContext context, Color color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: AutoSizeText(
        text,
        maxLines: 2,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      )));
}
