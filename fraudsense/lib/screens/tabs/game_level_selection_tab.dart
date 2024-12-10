import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/game/game_components/level_card.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/game/levels/level_manger.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';

class LevelSelectionTab extends ConsumerWidget {
  const LevelSelectionTab({super.key});
  Widget header(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 50,
        width: MediaQuery.sizeOf(context).width / 2,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              color: Colors.green.shade300),
          child: Center(
              child: Text(
            S.of(context).levelsTab_title,
            style: TextStyle(fontSize: 25, color: Colors.grey.shade900),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int unlockedIndex = ref.watch(userDataProvider).unlockedLevelsIndex;
    final levelsModel = ref.watch(levelsProvider);
    return Stack(
      children: [
        levelsModel.when(
          data: (data) {
            return ListView(
              padding: const EdgeInsets.only(top: 50),
              children: List.generate(
                data.levels.length,
                (index) => LevelCard(
                  levelIndex: index + 1,
                  unlocked: index <= unlockedIndex,
                  description: data.levels[index].description,
                  onStart: () {
                    LevelManger.instance.startLevel(
                      context: context,
                      ref: ref,
                      levelModel: data.levels[index],
                    );
                  },
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text("Error loading levels, ${error.toString()}"));
          },
          loading: () {
            return Center(child: Text(S.of(context).levelsTab_loading));
          },
        ),
        header(context),
      ],
    );
  }
}
