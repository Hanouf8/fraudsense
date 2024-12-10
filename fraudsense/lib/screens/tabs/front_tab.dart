import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/components/horizontal_card.dart';
import 'package:fraudsense/core/language/language_manager.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/user_data_model.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:fraudsense/screens/game%20screens/leaderboard_screen.dart';
import 'package:fraudsense/screens/game%20screens/statistics_screen.dart';

class FrontTab extends ConsumerStatefulWidget {
  const FrontTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FrontTabState();
}

class _FrontTabState extends ConsumerState<FrontTab> {
  @override
  Widget build(BuildContext context) {
    UserDataModel userData = ref.watch(userDataProvider);
    String userName = userData.userName;

    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const SizedBox(height: 20),
      SizedBox(
        height: 50,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 1, color: Colors.blueAccent)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                key: const Key("welcomeText"),
                textDirection: LanguageManager.isDirectionRTL(context),
                text: TextSpan(style: const TextStyle(color: Colors.black), children: [
                  TextSpan(
                      text: "${S.of(context).frontTab_welcomeText} ",
                      style: const TextStyle(fontSize: 15)),
                  TextSpan(
                      text: userName,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ]),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              HorizontalCard(
                icon: Icons.gamepad,
                title: S.of(context).frontTab_cardPlayGameTitle,
                description: S.of(context).frontTab_cardPlayGameDescription,
                onClick: () {
                  ref.read(homeTabIndexProvider.notifier).state = 1;
                },
              ),
              HorizontalCard(
                icon: Icons.co_present_outlined,
                title: S.of(context).frontTab_cardProgressTitle,
                description: S.of(context).frontTab_cardProgressDescription,
                onClick: () {
                  ref.read(homeTabIndexProvider.notifier).state = 2;
                },
              ),
              HorizontalCard(
                icon: Icons.leaderboard,
                title: S.of(context).frontTab_cardLeaderboardTitle,
                description: S.of(context).frontTab_cardLeaderboardDescription,
                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LeaderboardScreen();
                  }));
                },
              ),
              HorizontalCard(
                icon: Icons.feed_outlined,
                title: S.of(context).frontTab_statisticsTitle,
                description: S.of(context).frontTab_statisticsDescription,
                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const StatisticsScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
