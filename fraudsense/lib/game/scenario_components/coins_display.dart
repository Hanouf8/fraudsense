import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/providers/providers.dart';

Widget coinsDisplay() {
  return Consumer(builder: (context, ref, child) {
    int coins = ref.watch(userDataProvider).currency;
    return SizedBox(
      height: 40,
      width: 80,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.amber.shade500.withOpacity(0.6), borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.monetization_on,
              color: Colors.amber.shade100,
              size: 28,
            ),
            Expanded(
              child: AutoSizeText(
                textAlign: TextAlign.center,
                coins.toString(),
                maxFontSize: 20,
                minFontSize: 10,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
