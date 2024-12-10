import 'package:flutter_test/flutter_test.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:fraudsense/game/levels/level_io.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/levels_holder_model.dart';
import 'package:fraudsense/models/scenario_model.dart';

void main() {
  test("Total score for a list of levels", () {
    final scenarioModel = ScenarioModel.placeholderData().copyWith(scoreGainedOnCompletion: 10);
    //3 scenarios each returning 10 points
    List<ScenarioModel> scenarios = List.generate(3, (index) => scenarioModel);

    //3 levels each returning 3 scenarios, each scenario with 10 points, in total 90 points
    LevelsHolderModel levels = LevelsHolderModel(
        levels: List.generate(
            3, (index) => LevelModel(scenarios: scenarios, index: 0, description: "")),
        language: AppLanguage.en);

    int totalScore = levels.getTotalScore();

    expect(totalScore, 90);
  });

  test("Importing arabic levels from a json file returns arabic levels", () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    Result result = await LevelIO.importFromFile('assets/levels/levels_ar.json');

    expectLater(result.isSuccess, true);
    expectLater(result.data, isInstanceOf<LevelsHolderModel>());
    expectLater(result.data.language, AppLanguage.ar);
  });
  test("Importing english levels from a json file returns english levels", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Result result = await LevelIO.importFromFile('assets/levels/levels_en.json');

    expectLater(result.isSuccess, true);
    expectLater(result.data, isInstanceOf<LevelsHolderModel>());
    expectLater(result.data.language, AppLanguage.en);
  });

  test("Importing levels from a json file that doesn't exist should return error", () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    Result result = await LevelIO.importFromFile('assets/levels/levels_br.json');

    expectLater(result.isSuccess, false);
  });
}
