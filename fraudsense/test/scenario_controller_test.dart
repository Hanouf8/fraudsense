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

class MockSoundManger extends Mock implements SoundManager {}

class MockScenarioServices extends Mock implements ScenarioServices {}

void main() {
  late MockWidgetRef mockWidgetRef;
  late ProviderContainer container;
  late SoundManager mockedSoundManager;
  late ScenarioServices mockedScenarioServices;

  setUp(() {
    mockWidgetRef = MockWidgetRef();
    mockedSoundManager = MockSoundManger();
    mockedScenarioServices = MockScenarioServices();

    container = ProviderContainer(overrides: [
      timerValueProvider.overrideWith((ref) => 20),
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

    // mockRef = MockWidgetRef();
  });

  tearDown(() {
    container.dispose();
  });
  test("Timer decreases when the scenario starts", () async {
    int timeToSolveInSeconds = 10;
    //starting with no startingCharacterMessage so the game isn't paused and the timer starts
    final scenario = ScenarioModel.placeholderData()
        .copyWith(timeToSolveInSeconds: timeToSolveInSeconds, startingCharacterMessage: "");

    //initializing the ScenarioController
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

    //waiting 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    //expecting 6 seconds left out the initial 10 timeToSolveInSeconds
    expect(scenarioController.timerController.currentDurationLeft.inSeconds, 6);
    expect(container.read(timerValueProvider), 6);
  });

  test('Character dialog shows up at the start of the game', () async {
    const startingCharacterMessage = "Starting message";

    final scenario = ScenarioModel.placeholderData().copyWith(
      startingCharacterMessage: startingCharacterMessage,
    );
    //initializing the ScenarioController
    // ignore: unused_local_variable
    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: false,
      scenarioServices: mockedScenarioServices,
    );

    await Future.delayed(Duration.zero);

    verify(() => mockedScenarioServices.displayStartingCharacterMessage(
        onExit: any(named: 'onExit'), // Matches any function passed to 'onExit'
        textDirection: TextDirection.ltr,
        fullDialogueText: startingCharacterMessage)).called(1);
  });

  test('Pause game when theres a starting dialog', () async {
    final scenario = ScenarioModel.placeholderData();

    //initializing the ScenarioController
    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: false,
      scenarioServices: mockedScenarioServices,
    );
    expect(scenarioController.gamePaused, true);
  });

  test("Game isn't paused when theres no starting dialog", () async {
    final scenario = ScenarioModel.placeholderData().copyWith(
      startingCharacterMessage: "",
    );
    //initializing the ScenarioController
    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: LevelModel(index: 1, description: "", scenarios: [scenario]),
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: false,
      scenarioServices: mockedScenarioServices,
    );

    expect(scenarioController.gamePaused, false);
  });

  test('User gets coins when solving a scenario correctly', () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: true, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "");

    final parent = LevelModel(index: 1, description: "", scenarios: [scenario]);
    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: parent,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    expect(container.read(userDataProvider).currency, 0);

    //act
    AnswerModel correctAnswer = scenario.answers[0];
    scenarioController.submitAnswer(correctAnswer);

    //assert
    expect(container.read(userDataProvider).currency, 5 * parent.index);
  });

  test('User does not get coins when solving a scenario incorrectly', () async {
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

    expect(container.read(userDataProvider).currency, 0);

    //act
    AnswerModel incorrectAnswer = scenario.answers[0];
    scenarioController.submitAnswer(incorrectAnswer);

    //assert
    expect(container.read(userDataProvider).currency, 0);
  });
  test("User's score increases when solving a scenario correctly", () async {
    //setup
    const int scoreGainedOnCompletion = 10;
    final scenario = ScenarioModel.placeholderData().copyWith(answers: [
      const AnswerModel(text: "answer 1", isCorrect: true, explanationWhenIncorrect: "explanation")
    ], startingCharacterMessage: "", scoreGainedOnCompletion: scoreGainedOnCompletion);

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

    expect(container.read(userDataProvider).gameScore, 0);

    //act
    AnswerModel correctAnswer = scenario.answers[0];
    scenarioController.submitAnswer(correctAnswer);

    //assert
    expect(container.read(userDataProvider).gameScore, scoreGainedOnCompletion);
  });

  test("User score does not increase when solving a scenario incorrectly", () async {
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

    expect(container.read(userDataProvider).gameScore, 0);

    //act
    AnswerModel incorrectAnswer = scenario.answers[0];
    scenarioController.submitAnswer(incorrectAnswer);

    //assert
    expect(container.read(userDataProvider).gameScore, 0);
  });
  test("User score and coins do not increase when solving a scenario that was solved before",
      () async {
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
      currentScenarioIsAlreadySolved: true, //this is set to true
      scenarioServices: mockedScenarioServices,
    );

    expect(container.read(userDataProvider).gameScore, 0);
    expect(container.read(userDataProvider).currency, 0);

    //act
    AnswerModel correctAnswer = scenario.answers[0];
    scenarioController.submitAnswer(correctAnswer);

    //assert
    expect(container.read(userDataProvider).gameScore, 0);
    expect(container.read(userDataProvider).currency, 0);
  });

  test("Available hints decrease when unlocking a hint", () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(startingCharacterMessage: "");

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

    //the user starts with 3 hints
    container.read(userDataProvider.notifier).addHints(3);

    //act
    scenarioController.unlockCurrentHint();

    //assert
    expect(container.read(userDataProvider).availableHints, 2);
  });
  test("Available hints don't change when unlocking a hint that's already unlocked before",
      () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(startingCharacterMessage: "");
    final parent = LevelModel(index: 1, description: "", scenarios: [scenario]);

    final scenarioController = ScenarioController(
      targetScenario: scenario,
      textDirection: TextDirection.ltr,
      parent: parent,
      scenarioIndex: 0,
      soundManager: mockedSoundManager,
      ref: mockWidgetRef,
      currentScenarioIsAlreadySolved: null,
      scenarioServices: mockedScenarioServices,
    );

    container.read(userDataProvider.notifier).addHints(3);
    container
        .read(userDataProvider.notifier)
        .markHintUnlocked(levelModel: parent, scenarioIndex: 0);

    expect(container.read(userDataProvider).availableHints, 3);

    //act
    scenarioController.unlockCurrentHint();

    //assert
    expect(container.read(userDataProvider).availableHints, 3);
  });

  test("Buying a hint deducts coins and adds an available hint to the user data", () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(startingCharacterMessage: "");

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

    container.read(userDataProvider.notifier).addCoins(100);

    expect(container.read(userDataProvider).currency, 100);

    //act
    scenarioController.buyHint(75);

    //assert
    expect(container.read(userDataProvider).currency, 25);
    expect(container.read(userDataProvider).availableHints, 1);
  });

  test("Buying a hint without enough coins doesn't increase available hints", () async {
    //setup
    final scenario = ScenarioModel.placeholderData().copyWith(startingCharacterMessage: "");

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

    container.read(userDataProvider.notifier).addCoins(50);

    expect(container.read(userDataProvider).currency, 50);

    //act
    scenarioController.buyHint(75);

    //assert
    expect(container.read(userDataProvider).currency, 50);
    expect(container.read(userDataProvider).availableHints, 0);
  });
}
