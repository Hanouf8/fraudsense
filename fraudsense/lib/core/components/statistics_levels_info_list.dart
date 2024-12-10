import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/utils/level_utilities.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:fraudsense/providers/providers.dart';

class StatisticsLevelsInfoList extends ConsumerWidget {
  const StatisticsLevelsInfoList({super.key});

  int _fastestSolveTime(Map<int, List<int>> completedLevels) {
    int fastestSolveTime = 10000;
    completedLevels.forEach((key, value) {
      if (value[1] < fastestSolveTime) {
        fastestSolveTime = value[1];
      }
    });

    return fastestSolveTime;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserDataModel userData = ref.watch(userDataProvider);

    Map<int, List<int>> completedLevels = LevelUtilities.compileCompletedLevelMetrics(userData);

    List keyList = completedLevels.keys.toList();

    int fastestSolveTime = _fastestSolveTime(completedLevels);

    // return Center(child: Text("Levels completed: ${completedLevels[2]?.length}"));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        child: Center(
                            child: Text(S.of(context).statisticsScreen_levelsListLevelTitle))),
                    Expanded(
                        child: Center(
                            child: Text(S.of(context).statisticsScreen_levelsListFailsTitle))),
                    Expanded(
                        child: Center(
                            child: Text(S.of(context).statisticsScreen_levelsListSolveTimeTitle)))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      bool isFastestSolveTime =
                          completedLevels[keyList[index]]?[1] == fastestSolveTime;

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50, borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: Container(
                                      // color: Colors.red,
                                      child: Center(
                                          child: Text("${keyList[index]}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 14))))),
                              Expanded(
                                child: Container(
                                    // color: Colors.blue,
                                    child: Center(
                                        child: Text("${completedLevels[keyList[index]]?[0]}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            )))),
                              ),
                              Expanded(
                                child: Container(
                                  // color: Colors.green,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${completedLevels[keyList[index]]?[1]}s",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: isFastestSolveTime
                                                  ? Colors.amber
                                                  : Colors.black)),
                                      if (isFastestSolveTime)
                                        const Icon(Icons.emoji_events,
                                            color: Colors.amber, size: 20)
                                    ],
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: completedLevels.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
