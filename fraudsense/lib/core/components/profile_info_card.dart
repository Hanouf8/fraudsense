import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key, required this.icon, required this.title, required this.info});

  final IconData icon;
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Container(
        decoration:
            BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 6.0),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Center(child: Icon(icon, size: 25))),
            )),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(info)
              ],
            )),
          ],
        ),
      ),
    );
  }
}
