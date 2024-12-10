import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/components/statistics_info_card.dart';
import 'package:fraudsense/core/components/statistics_levels_info_list.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:fraudsense/providers/providers.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    UserDataModel userDataModel = ref.watch(userDataProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.green[200],
              title: Text(S.of(context).frontTab_statisticsTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold)),
              centerTitle: true),
        ),
      ),
      body: FutureBuilder(
          future: ref.read(cloudControllerProvider).getUserRanking(userDataModel.userName),
          builder: (context, snapshot) {
            //return a loading indicator while the data is being fetched
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  S.of(context).levelsTab_loading,
                  textDirection: ref.read(languageProvider.notifier).textDirectionFromLang(),
                ),
              );
            }
            //returns the widget with the data if the request was successful
            if (snapshot.data!.isSuccess) {
              return SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //General
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 10),
                    child: Text(
                      S.of(context).statisticsScreen_generalTitleText,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  StatisticsInfoCard(
                      icon: Icons.rotate_90_degrees_cw_sharp,
                      title: S.of(context).statisticsScreen_loggedDays,
                      info: userDataModel.loggedInDays.toString()),
                  StatisticsInfoCard(
                      icon: Icons.leaderboard_rounded,
                      title: S.of(context).statisticsScreen_ranking,
                      info: "#${snapshot.data!.data.toString()}"),
                  //Streak
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
                    child: Text(
                      S.of(context).statisticsScreen_streakTitleText,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  StatisticsInfoCard(
                      icon: Icons.rocket_launch,
                      title: S.of(context).statisticsScreen_currentStreak,
                      info: userDataModel.currentStreak.toString()),
                  StatisticsInfoCard(
                      icon: Icons.rocket_rounded,
                      title: S.of(context).statisticsScreen_longestStreak,
                      info: userDataModel.longestStreak.toString()),
                  //Levels
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
                    child: Text(
                      S.of(context).statisticsScreen_levelsTitleText,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  StatisticsInfoCard(
                      icon: Icons.emoji_events,
                      title: S.of(context).statisticsScreen_unlockedLevels,
                      info: ((userDataModel.unlockedLevelsIndex) + 1).toString()),
                  //Levels list
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20) +
                            const EdgeInsets.only(top: 20),
                        child: Text(
                          S.of(context).statisticsScreen_levelsListTitle,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const StatisticsLevelsInfoList(),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ));
            }
            //returning error if we have no data
            return StatisticsInfoCard(
                icon: Icons.leaderboard_rounded,
                title: S.of(context).statisticsScreen_ranking,
                info: "error");
          }),
    );
  }
}
