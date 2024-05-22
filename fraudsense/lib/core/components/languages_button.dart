import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {}, child: const AutoSizeText('EN | عربى'));
  }
}
