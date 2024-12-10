import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/components/profile_achievements_card.dart';
import 'package:fraudsense/core/components/profile_info_card.dart';

import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    UserDataModel userDataModel = ref.watch(userDataProvider);

    int totalLevels = 0;
    int totalScore = 0;

    int completedLevels = userDataModel.unlockedLevelsIndex;
    int currentScore = userDataModel.gameScore;

    ref.watch(levelsProvider).whenData((levelsHolder) {
      totalScore = levelsHolder.getTotalScore();
      totalLevels = levelsHolder.levels.length;
    });

    double levelCompletionPercentage = completedLevels / totalLevels;
    double scoreCompletionPercentage = currentScore / totalScore;
    bool achievementsAreLoaded = totalLevels != 0 && totalScore != 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Username and profile pic
        Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AutoSizeText("@${userDataModel.userName}",
                      textDirection: TextDirection.ltr,
                      minFontSize: 10,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ),
        //Score, Coins, Hints
        Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ProfileInfoCard(
                  icon: Icons.local_fire_department,
                  title: S.of(context).profileTab_points,
                  info: userDataModel.gameScore.toString(),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ProfileInfoCard(
                  icon: Icons.monetization_on,
                  title: S.of(context).profileTab_coins,
                  info: userDataModel.currency.toString(),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: ProfileInfoCard(
                  icon: Icons.quickreply_rounded,
                  title: S.of(context).profileTab_hints,
                  info: userDataModel.availableHints.toString(),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        //Achievements Title
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Text(
            S.of(context).profileTab_achievements,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        //Achievements
        if (achievementsAreLoaded) //
          Expanded(
            child: Column(
              children: [
                ProfileAchievementsCard(
                  icon: Icons.done_all_rounded,
                  title: S.of(context).profileTab_achievementsCompletedLevelsTitle,
                  info: "$completedLevels/$totalLevels",
                  percentage: levelCompletionPercentage,
                  bottomText: S.of(context).profileTab_achievementsCompletedLevelsBottomText,
                ),
                ProfileAchievementsCard(
                  icon: Icons.done_all_rounded,
                  title: S.of(context).profileTab_achievementsPointsTitle,
                  info: "$currentScore/$totalScore",
                  percentage: scoreCompletionPercentage,
                  bottomText:
                      "${S.of(context).profileTab_achievementsPointsBottomText1} $totalScore ${S.of(context).profileTab_achievementsPointsBottomText2}",
                ),
              ],
            ),
          )
      ],
    );
  }
}
