import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/providers/game_providers.dart';

Widget timerDisplay() {
  return Consumer(builder: (context, ref, child) {
    int time = ref.watch(timerValueProvider);
    return SizedBox(
      height: 40,
      width: 100,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                Icons.timer_sharp,
                color: Colors.white,
                size: 28,
              ),
            ),
            Text(
              " ${time}s",
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  });
}
