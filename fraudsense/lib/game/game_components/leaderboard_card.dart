import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LeaderboardScoreCard extends StatelessWidget {
  const LeaderboardScoreCard(
      {super.key, required this.name, required this.score, required this.rank});
  final String name;
  final int score;
  final int rank;

  @override
  Widget build(BuildContext context) {
    Color cardColorTheme = Colors.grey;
    Color cardBackgroundColor = Colors.white;
    int rankFontSize = 18;

    if (rank == 1) {
      cardColorTheme = Colors.amber;
    } else if (rank == 2) {
      cardColorTheme = Colors.blue;
    } else if (rank == 3) {
      cardColorTheme = Colors.red;
    }

    return SizedBox(
      height: 40,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cardBackgroundColor,
            border: Border.all(color: Colors.grey.shade500, width: 1)),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Center(
                        child: AutoSizeText(
                          name,
                          style: TextStyle(
                              fontSize: 16, color: cardColorTheme, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )),
                VerticalDivider(
                  thickness: 1,
                  color: Colors.grey.shade500,
                ),
                Flexible(
                  child: Center(
                    child: Text(
                      score.toString(),
                      style: const TextStyle(
                          fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: cardColorTheme.withOpacity(0.8),
                      child: Text(
                        "$rank",
                        style: TextStyle(fontSize: rankFontSize.toDouble(), color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}