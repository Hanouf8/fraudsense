import 'package:flutter/material.dart';

class ProfileAchievementsCard extends StatelessWidget {
  const ProfileAchievementsCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.info,
      required this.percentage,
      required this.bottomText});

  final IconData icon;
  final String title;
  final String info;
  final double percentage;
  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
          height: 100,
          child: Container(
            decoration:
                BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                //sized box with the width of 10 so the sized box below it can be aligned
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Center(child: Icon(icon, size: 30)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Text(info, style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    LinearProgressIndicator(
                      value: percentage,
                      minHeight: 5,
                      color: Colors.green,
                    ),
                    Text(bottomText, style: const TextStyle(fontSize: 13)),
                  ],
                )),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )),
    );
  }
}
