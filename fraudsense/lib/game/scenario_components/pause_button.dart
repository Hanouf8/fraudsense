import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade700, borderRadius: BorderRadius.circular(15)),
      child: IconButton(
        onPressed: () {
          onClick();
        },
        icon: const Icon(
          Icons.pause,
          color: Colors.white,
        ),
      ),
    );
  }
}
