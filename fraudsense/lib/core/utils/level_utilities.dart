import 'package:fraudsense/core/utils/list_utilities.dart';
import 'package:fraudsense/models/user_data_model.dart';

class LevelUtilities {
  ///This function takes a user data model and returns a map of completed levels
  ///as keys and a list of 2 integers as the value. The first integer is the total
  ///number of fails in that level, and the second integer is the total time to
  ///solve the level. If the level index is not in the solvedScenarios of the user
  ///data, it is ignored.
  static Map<int, List<int>> compileCompletedLevelMetrics(UserDataModel userData) {
    //The list is gonna be of 2 integers: [ fails, total time to solve] and the key is the level index
    Map<int, List<int>> completedLevels = {};

    userData.solvedScenarios.forEach((levelIndex, levelScenarios) {
      //this returns true if the level is unlocked
      if (levelIndex <= userData.unlockedLevelsIndex) {
        completedLevels[levelIndex] = List.empty(growable: true);
        //we add teh total fails and total time to solve
        completedLevels[levelIndex]
            ?.add(ListUtilities.sumUpList(userData.scenariosFails[levelIndex]));
        completedLevels[levelIndex]
            ?.add(ListUtilities.sumUpList(userData.solvedTimeForScenarios[levelIndex]));
      }
    });

    return completedLevels;
  }
}
