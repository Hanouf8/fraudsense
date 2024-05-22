import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fraudsense/screens/games_screen/games_screen.dart';
import 'package:fraudsense/screens/menu_screen/screen/menu_screen.dart';
import 'package:fraudsense/screens/notifications_screen/notifications_screen.dart';
import 'package:fraudsense/screens/profile_screen/screen/profile_screen.dart';

class ScreensDisplay extends StatefulWidget {
  const ScreensDisplay({super.key});

  @override
  State<ScreensDisplay> createState() => _ScreensDisplayState();
}

class _ScreensDisplayState extends State<ScreensDisplay> {
  int currentIndex = 0;
  List<Widget> appScreens = const [
    MenuScreen(),
    GamesScreen(),
    ProfileScreen(),
    NotificationsScreen(),
  ];
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.blueAccent)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Singed in as: ${user.email!}",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
        leading: Container(
          child: TextButton(
            child: Icon(
              Icons.reset_tv_rounded,
              color: Colors.red.shade300,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ),
      ),
      body: appScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.gamepad,
                  color: Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                label: ''),
          ]),
    );
  }
}
