import 'package:flutter/material.dart';

class ProfileScreenData {
  final IconData icon;
  final String title;
  final String value;

  ProfileScreenData(
      {required this.icon, required this.title, required this.value});
}

final List<ProfileScreenData> achievmentsData = [
  ProfileScreenData(icon: Icons.fire_hydrant, title: 'Points', value: '300'),
  ProfileScreenData(
      icon: Icons.hourglass_bottom, title: 'Time Spent', value: '5 hrs'),
  ProfileScreenData(icon: Icons.stars, title: 'Prizes', value: '7'),
];
