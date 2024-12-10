import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard(
      {super.key,
      required this.onClick,
      required this.title,
      required this.description,
      required this.icon});

  final VoidCallback onClick;
  final IconData icon;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: SizedBox(
        height: 90,
        // width: 800,
        child: GestureDetector(
          onTap: () {
            onClick();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 90,
                  width: 90,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), color: Colors.white),
                      child: Center(
                          child: Icon(
                        color: Colors.grey.shade800,
                        icon,
                        size: 50,
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                        ),
                        AutoSizeText(
                          overflow: TextOverflow.visible,
                          description,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.scale(scale: -1, child: const Icon(Icons.arrow_back_ios_rounded)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
