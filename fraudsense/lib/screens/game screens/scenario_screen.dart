import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/components/space_boxes.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/game/scenario_components/character_text_box.dart';
import 'package:fraudsense/game/scenario_components/coins_display.dart';
import 'package:fraudsense/game/scenario_components/fake_mobile_screen.dart';
import 'package:fraudsense/game/scenario_components/hints_pop_up.dart';
import 'package:fraudsense/game/scenario_components/pause_button.dart';
import 'package:fraudsense/game/scenario_components/quiz_box.dart';
import 'package:fraudsense/game/scenario_components/scenario_controller.dart';
import 'package:fraudsense/game/scenario_components/scenario_services.dart';
import 'package:fraudsense/game/scenario_components/shop_pop_up.dart';
import 'package:fraudsense/game/scenario_components/timer_display.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:fraudsense/models/scenario_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';

class ScenarioScreen extends ConsumerStatefulWidget {
  const ScenarioScreen(
      {super.key,
      required this.scenarioModel,
      required this.textDirection,
      required this.parent,
      required this.index});

  final ScenarioModel scenarioModel;
  final TextDirection textDirection;
  final LevelModel parent;
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScenarioScreenState();
}

class _ScenarioScreenState extends ConsumerState<ScenarioScreen> with WidgetsBindingObserver {
  late final ScenarioController _scenarioController;

  @override
  void initState() {
    bool? currentScenarioIsAlreadySolved = ref
        .read(userDataProvider.notifier)
        .isScenarioAlreadySolved(levelIndex: widget.parent.index, scenarioIndex: widget.index);

    _scenarioController = ScenarioController(
        targetScenario: widget.scenarioModel,
        textDirection: widget.textDirection,
        parent: widget.parent,
        scenarioIndex: widget.index,
        scenarioServices: ScenarioServices(context: context, ref: ref),
        soundManager: SoundManager.instance,
        currentScenarioIsAlreadySolved: currentScenarioIsAlreadySolved,
        ref: ref);
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    print("disposing scenario screen widget");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _scenarioController.onPauseButtonClick();
        break;
      case AppLifecycleState.hidden:
        _scenarioController.onPauseButtonClick();
        break;
      case AppLifecycleState.inactive:
        _scenarioController.onPauseButtonClick();
        break;
      default:
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilding scenario screen widget (this shouldn't happen regularly)");

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _scenarioController.onPauseButtonClick();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: AppBar(
              toolbarHeight: 60,
              backgroundColor: Colors.grey.shade800,
              scrolledUnderElevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      PauseButton(onClick: () => _scenarioController.onPauseButtonClick()),
                      const SizedBox(
                        width: 20,
                      ),
                      coinsDisplay(),
                    ],
                  ),
                  timerDisplay(),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black87,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            characterHintBox(hint: widget.scenarioModel.hint),
            const VerticalSpace(height: .01),
            FakeMobileScreen(
              contactTitle: widget.scenarioModel.contactTitle,
              receivedMessage: widget.scenarioModel.receivedMessage,
              receivedLink: widget.scenarioModel.receivedLink,
              isVerifiedContact: widget.scenarioModel.isVerifiedContact,
              messageTime: widget.scenarioModel.messageTime,
              textDirection: widget.textDirection,
            ),
            const VerticalSpace(height: .03),
            QuizBox(
              question: widget.scenarioModel.question,
              answers: widget.scenarioModel.answers,
              onSubmit: _scenarioController.submitAnswer,
              textDirection: widget.textDirection,
            ),
          ],
        ),
      ),
    );
  }

  Widget characterHintBox({required String hint}) {
    return Consumer(
      builder: (context, ref, child) {
        final bool didShowHint = ref.watch(displayCurrentHintProvider);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: CharacterTextBox(
              message: hint,
              showMessage: didShowHint,
              onCharacterClick: () {
                if (_scenarioController.gamePaused) return;
                if (didShowHint) return;

                return showHintsPopUp(
                  levelModel: widget.parent,
                  scenarioIndex: widget.index,
                  context: context,
                  ref: ref,
                  onUnlockHint: () {
                    _scenarioController.unlockCurrentHint();
                  },
                  onOpenShop: () {
                    showShopPopUp(
                        context: context,
                        ref: ref,
                        price: 75,
                        onBuy: () => _scenarioController.buyHint(75),
                        onReturn: () {
                          _scenarioController.unpauseGame();
                        });
                    _scenarioController.pauseGame();
                  },
                );
              },
              imagePath: "assets/images/character/character_hint.png",
              textDirection: widget.textDirection),
        );
      },
    );
  }
}
