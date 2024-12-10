import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/providers/providers.dart';

class LanguageButton extends ConsumerWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: () {
          ref.read(languageProvider.notifier).toggle();
        },
        child: const AutoSizeText(
          'EN | عربى',
          textDirection: TextDirection.ltr,
        ));
  }
}
