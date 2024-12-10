import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fraudsense/cloud/cloud_controller.dart';
import 'package:fraudsense/cloud/cloud_services.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/core/utils/level_utilities.dart';
import 'package:fraudsense/game/scenario_components/scenario_controller.dart';
import 'package:fraudsense/game/scenario_components/scenario_services.dart';
import 'package:fraudsense/models/answer_model.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/scenario_model.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:mocktail/mocktail.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockSoundManger extends Mock implements SoundManager {}

class MockScenarioServices extends Mock implements ScenarioServices {}

class MockCloudServices extends Mock implements CloudServices {}

void main() {
  late ProviderContainer container;
  late MockWidgetRef mockWidgetRef;
  late SoundManager mockedSoundManager;
  late ScenarioServices mockedScenarioServices;
  late CloudServices mockCloudServices;
  late CloudController cloudController;

  setUp(() {
    mockWidgetRef = MockWidgetRef();
    mockedSoundManager = MockSoundManger();
    mockedScenarioServices = MockScenarioServices();
    mockCloudServices = MockCloudServices();
    cloudController = CloudController(mockCloudServices);

    container = ProviderContainer(overrides: [
      timerValueProvider.overrideWith((ref) => 20),
      submittedAnswerProvider.overrideWith((ref) => null),
      selectedAnswerProvider.overrideWith((ref) => null),
    ]);

    when(() => mockWidgetRef.read(timerValueProvider.notifier))
        .thenReturn(container.read(timerValueProvider.notifier));

    when(() => mockWidgetRef.read(userDataProvider.notifier))
        .thenReturn(container.read(userDataProvider.notifier));

    when(() => mockWidgetRef.read(userDataProvider)).thenReturn(container.read(userDataProvider));

    when(() => mockWidgetRef.read(submittedAnswerProvider.notifier))
        .thenReturn(container.read(submittedAnswerProvider.notifier));

    when(() => mockWidgetRef.read(unsolvedScenariosListProvider.notifier))
        .thenReturn(container.read(unsolvedScenariosListProvider.notifier));

    when(() => mockWidgetRef.read(displayCurrentHintProvider.notifier))
        .thenReturn(container.read(displayCurrentHintProvider.notifier));

    when(() => mockedScenarioServices.rightAnswerMessage(any())).thenReturn("right answer message");
    when(() => mockedScenarioServices.wrongAnswerMessage).thenReturn("wrong answer message");
  });

  tearDown(() {
    container.dispose();
  });

  test("Updating logged in days", () {
    //expecting the logged in days to be 0
    expect(container.read(userDataProvider).loggedInDays, 0);

    //updating the last logged in day to 2024/01/01
    container.read(userDataProvider.notifier).updateLoggedInDays(currentDate: "2024/01/01");

    //expecting the logged in days to be 1
    expect(container.read(userDataProvider).loggedInDays, 1);

    //updating the last logged in day to 2024/01/02
    container.read(userDataProvider.notifier).updateLoggedInDays(currentDate: "2024/01/02");

    //expecting the logged in days to be 2
    expect(container.read(userDataProvider).loggedInDays, 2);
  });

  test('Streak increments when solving a scenario correctly', () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: true, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "");

    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    when(() => mockedScenarioServices.rightAnswerMessage(any())).thenReturn("right answer message");

    expect(container.read(userDataProvider).currentStreak, 0);

    //act
    AnswerModel correctAnswer = scenario.answers[0];
    scenarioController.submitAnswer(correctAnswer);

    //assert
    expect(container.read(userDataProvider).currentStreak, 1);
  });

  test('Streak rests when solving a scenario incorrectly', () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: false, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "");

    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    when(() => mockedScenarioServices.wrongAnswerMessage).thenReturn("wrong answer message");

    container.read(userDataProvider.notifier).increaseStreak();
    container.read(userDataProvider.notifier).increaseStreak();
    container.read(userDataProvider.notifier).increaseStreak();

    expect(container.read(userDataProvider).currentStreak, 3);

    //act
    AnswerModel incorrectAnswer = scenario.answers[0];
    scenarioController.submitAnswer(incorrectAnswer);

    //assert
    expect(container.read(userDataProvider).currentStreak, 0);
  });

  test('Getting the ranking of a specific user', () async {
    //mocking and returning a list of users with different game scores
    when(() => mockCloudServices.getAllUsers()).thenAnswer((_) async {
      return [
        UserDataModel.emptyData().copyWith(userName: 'user1', gameScore: 100),
        UserDataModel.emptyData().copyWith(userName: 'user2', gameScore: 200),
        UserDataModel.emptyData().copyWith(userName: 'user3', gameScore: 300),
      ];
    });

    final result = await cloudController.getUserRanking('user3');

    expectLater(result.isSuccess, true);

    //expecting user3 with the most score to be top 1
    expectLater(result.data!, 1);
  });

  test('Getting the ranking of a specific user that does not exist', () async {
    //mocking and returning a list of users with different game scores
    when(() => mockCloudServices.getAllUsers()).thenAnswer((_) async {
      return [
        UserDataModel.emptyData().copyWith(userName: 'user1', gameScore: 100),
        UserDataModel.emptyData().copyWith(userName: 'user2', gameScore: 200),
        UserDataModel.emptyData().copyWith(userName: 'user3', gameScore: 300),
      ];
    });

    //getting a ranking of a user that doesn't exist
    final result = await cloudController.getUserRanking('user4');

    expectLater(result.isSuccess, false);

    //expecting an error if user is not found
    expectLater(result.error, 'user-not-found');
  });

  test('Failing the same scenario multiple times gets stored in the user data', () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: false, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "");

    //initializing and starting a scenario
    ScenarioController scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //solving it wrong
    AnswerModel wrongAnswer = scenario.answers[0];
    scenarioController.submitAnswer(wrongAnswer);

    //initializing and starting the same scenario again (same index)
    scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //solving it wrong again
    scenarioController.submitAnswer(wrongAnswer);

    //initializing and starting the same scenario yet again (same index)
    scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //solving it wrong
    scenarioController.submitAnswer(wrongAnswer);

    //expecting the user to have failed 3 times in the first scenario in the level with index 1
    expect(container.read(userDataProvider).scenariosFails[1]![0], 3);
  });

  test('Solve time for the scenarios gets stored in the user data', () async {
    //listening to the submittedAnswerProvider so it does not auto dispose in the middle of our test
    //we usually don't need to do this but since we are waiting then submitting our answer it gets automatically disposed
    container.listen<bool?>(submittedAnswerProvider, (_, __) {});

    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: true, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "");

    //making our level have 2 scenarios in it
    final level = LevelModel(index: 1, description: "", scenarios: [scenario, scenario]);

    //starting the first scenario, with scenarioIndex set to 0
    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: level,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    AnswerModel correctAnswer = scenario.answers[0];

    //waiting 2 seconds then solving it correctly (we are waiting for an additional 100 milliseconds to account for the timer rounding up)
    await Future.delayed(const Duration(milliseconds: 2100));

    scenarioController.submitAnswer(correctAnswer);

    //starting the second scenario, with scenarioIndex set to 1
    final scenarioController1 = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: level,
      scenarioIndex: 1,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //waiting 1 seconds then solving it correctly (we are waiting for an additional 100 milliseconds to account for the timer rounding up)
    await Future.delayed(const Duration(milliseconds: 1100));
    scenarioController1.submitAnswer(correctAnswer);

    //expecting our user data to have a solve time of 2 for the first scenario
    expect(container.read(userDataProvider).solvedTimeForScenarios[1]![0], 2);
    //then a solve time of 1 for the second scenario
    expect(container.read(userDataProvider).solvedTimeForScenarios[1]![1], 1);
  });
  test("Getting the total solve time for a level", () async {
    //listening to the submittedAnswerProvider so it does not auto dispose in the middle of our test
    //we usually don't need to do this but since we are waiting then submitting our answer it gets automatically disposed
    container.listen<bool?>(submittedAnswerProvider, (_, __) {});

    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: true, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "");

    //making our level have 2 scenarios in it
    final level = LevelModel(index: 1, description: "", scenarios: [scenario, scenario]);

    //starting the first scenario, with scenarioIndex set to 0
    ScenarioController scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: level,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    AnswerModel correctAnswer = scenario.answers[0];

    //waiting 2 seconds then solving it correctly (we are waiting for an additional 100 milliseconds to account for the timer rounding up)
    await Future.delayed(const Duration(milliseconds: 2100));
    scenarioController.submitAnswer(correctAnswer);

    //starting the second scenario, with scenarioIndex set to 1
    scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: level,
      scenarioIndex: 1,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    //waiting 1 seconds then solving it correctly (we are waiting for an additional 100 milliseconds to account for the timer rounding up)
    await Future.delayed(const Duration(milliseconds: 1100));

    scenarioController.submitAnswer(correctAnswer);

    //making sure the user has unlocked level 1
    container.read(userDataProvider.notifier).unlockedLevel(1);

    //getting the complied level metrics
    final Map<int, List<int>> compliedLevelMetrics =
        LevelUtilities.compileCompletedLevelMetrics(container.read(userDataProvider));

    //expecting the level with the index of 1, to  have the solve time totaling  at 3 seconds
    expect(compliedLevelMetrics[1]![1], 3);
  });
}
