import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/game/scenario_components/scenario_controller.dart';
import 'package:fraudsense/game/scenario_components/scenario_services.dart';
import 'package:fraudsense/models/answer_model.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/scenario_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:mocktail/mocktail.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockLevelModel extends Mock implements LevelModel {}

class MockSoundManger extends Mock implements SoundManager {}

class MockScenarioServices extends Mock implements ScenarioServices {}

void main() {
  late LevelModel mockedLevelModel;
  late MockWidgetRef mockWidgetRef;
  late ProviderContainer container;
  late SoundManager mockedSoundManager;
  late ScenarioServices mockedScenarioServices;

  setUp(() {
    mockWidgetRef = MockWidgetRef();
    mockedSoundManager = MockSoundManger();
    mockedScenarioServices = MockScenarioServices();
    mockedLevelModel = MockLevelModel();

    container = ProviderContainer(overrides: [
      timerValueProvider.overrideWith((ref) => 20),
    ]);

    when(() => mockedLevelModel.scenarios.length).thenReturn(5);
    when(() => mockedLevelModel.index).thenReturn(1);

    when(() => mockWidgetRef.read(timerValueProvider.notifier))
        .thenReturn(container.read(timerValueProvider.notifier));

    when(() => mockWidgetRef.read(userDataProvider.notifier))
        .thenReturn(container.read(userDataProvider.notifier));

    when(() => mockWidgetRef.read(userDataProvider)).thenReturn(container.read(userDataProvider));

    when(() => mockWidgetRef.read(submittedAnswerProvider.notifier))
        .thenReturn(container.read(submittedAnswerProvider.notifier));

    when(() => mockWidgetRef.read(unsolvedScenariosListProvider.notifier))
        .thenReturn(container.read(unsolvedScenariosListProvider.notifier));
  });

  tearDown(() {
    container.dispose();
  });

  test("Unsolved scenarios list increases when a scenario is solved incorrectly", () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "test", isCorrect: false, explanationWhenIncorrect: "test")
    ], startingCharacterMessage: "");

    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: mockedLevelModel,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    when(() => mockedLevelModel.scenarios).thenReturn([scenario]);
    when(() => mockedScenarioServices.wrongAnswerMessage).thenReturn("wrong answer message");

    //expecting the list to be empty
    expect(container.read(unsolvedScenariosListProvider).isEmpty, true);

    //submitting an incorrect answer
    AnswerModel incorrectAnswer = scenario.answers[0];
    scenarioController.submitAnswer(incorrectAnswer);

    //expecting the list to have one item
    expect(container.read(unsolvedScenariosListProvider).length, 1);
  });

  test("Unsolved scenarios list increases when the timer runs out and a scenario is left unsolved",
      () async {
    int timeToSolveInSeconds = 2;
    final scenario = ScenarioModel.placeholderData()
        .copyWith(timeToSolveInSeconds: timeToSolveInSeconds, startingCharacterMessage: "");

    // ignore: unused_local_variable
    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: mockedLevelModel,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    when(() => mockedLevelModel.scenarios).thenReturn([scenario]);

    //expecting the list to be empty
    expect(container.read(unsolvedScenariosListProvider).isEmpty, true);

    //waiting until the timer runs out + 1 extra second to account for any delay functions being called
    await Future.delayed(Duration(seconds: timeToSolveInSeconds + 1));

    //expecting the list to have one item
    expect(container.read(unsolvedScenariosListProvider).length, 1);
  });

  test(
      "Unsolved scenarios list can return only the scenarios that are solved incorrectly (Mistakes)",
      () async {
    int timeToSolveInSeconds = 2;
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "test", isCorrect: false, explanationWhenIncorrect: "test")
    ], startingCharacterMessage: "", timeToSolveInSeconds: timeToSolveInSeconds);

    when(() => mockedLevelModel.scenarios).thenReturn([scenario, scenario]);
    when(() => mockedScenarioServices.wrongAnswerMessage).thenReturn("wrong answer message");

    final scenarioController1 = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: mockedLevelModel,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //submitting an incorrect answer
    AnswerModel incorrectAnswer = scenario.answers[0];
    scenarioController1.submitAnswer(incorrectAnswer);

    //expecting the list to have one item
    expect(container.read(unsolvedScenariosListProvider).length, 1);

    //initializing a new scenario
    // ignore: unused_local_variable
    final scenarioController2 = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: mockedLevelModel,
      scenarioIndex: 1,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //waiting until the timer runs out + 1 extra second to account for any delay functions being called
    await Future.delayed(Duration(seconds: timeToSolveInSeconds + 1));

    //expecting the list to have two items, one solved incorrectly and one unsolved due to time running out
    expect(container.read(unsolvedScenariosListProvider).length, 2);

    //expecting a list of scenarios that are solved incorrectly only without including the unsolved scenario due to time running out
    expect(
        container.read(unsolvedScenariosListProvider.notifier).scenariosSolvedIncorrectly().length,
        1);
    //expecting the first item of the list to have a picked answer
    expect(
        container
            .read(unsolvedScenariosListProvider.notifier)
            .scenariosSolvedIncorrectly()[0]
            .pickedAnswer,
        isNotNull);
  });
}
