import 'package:flutter/material.dart';

class MenuScreenData {
  final IconData icon;
  final String title;
  final String description;

  MenuScreenData(
      {required this.icon, required this.title, required this.description});
}

final List<MenuScreenData> menuData = [
  MenuScreenData(
      icon: Icons.games,
      title: 'Play a Game',
      description: 'Test your phishing detection skills'),
  MenuScreenData(
      icon: Icons.file_copy,
      title: 'Report Analysis',
      description:
          'Detailed report of all user data related to Fraudsense app'),
  MenuScreenData(
      icon: Icons.sync,
      title: 'View Progress',
      description: 'Track your progress and achievements'),
  MenuScreenData(
      icon: Icons.bar_chart,
      title: 'View Leaderboard',
      description:
          'Measure your phising detection abilites against other users'),
];
