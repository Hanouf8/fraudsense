import 'package:flutter/material.dart';

class StatisticsInfoCard extends StatelessWidget {
  const StatisticsInfoCard(
      {super.key, required this.icon, required this.title, required this.info});

  final IconData icon;
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
          height: 80,
          child: Container(
            decoration:
                BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                //sized box with the width of 10 so the sized box below it can be aligned
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Center(child: Icon(icon, size: 30)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(info, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          )),
    );
  }
}
