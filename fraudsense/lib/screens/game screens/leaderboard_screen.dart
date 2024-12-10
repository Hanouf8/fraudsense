import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/game/game_components/leaderboard_card.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/providers/providers.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  Widget cardsList(List<Widget> cards) {
    return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: cards[index],
          );
        });
  }

  Widget header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Container(
            // color: Colors.amber,
            child: Row(
              children: [
                Flexible(
                    flex: 2,
                    child: Center(
                        child: Text(S.of(context).game_leaderboardUsername,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey.shade800)))),
                Flexible(
                    child: Center(
                        child: Text(
                  S.of(context).game_leaderboardPoints,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ))),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: Colors.green[200],
                title: Text(S.of(context).game_leaderboardTitle,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold)),
                centerTitle: true,
                flexibleSpace: header()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade50,
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: FutureBuilder(
                  //Getting the top users from the cloud using the cloud controller and show a loading indicator until the data is fetched
                  future: ref.read(cloudControllerProvider).getTopUsers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          S.of(context).levelsTab_loading,
                          textDirection:
                              ref.read(languageProvider.notifier).textDirectionFromLang(),
                        ),
                      );
                    }
                    //Displaying the top users when the data is fetched
                    if (snapshot.data!.isSuccess) {
                      List<LeaderboardScoreCard> cards = List.empty(growable: true);
                      for (var i = 0; i < snapshot.data!.data!.length; i++) {
                        cards.add(LeaderboardScoreCard(
                          rank: i + 1,
                          name: snapshot.data!.data![i].userName,
                          score: snapshot.data!.data![i].gameScore,
                        ));
                      }
                      return cardsList(cards);
                    }
                    //Displaying an error message if the data is not fetched correctly
                    return Text("ERROR GETTING DATA: ${snapshot.data!.error}");
                  }),
            ),
          )),
    );
  }
}
