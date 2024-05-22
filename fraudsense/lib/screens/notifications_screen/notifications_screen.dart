import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AutoSizeText('Notifications'),
    );
  }
}
