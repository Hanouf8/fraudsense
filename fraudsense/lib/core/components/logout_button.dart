import 'package:flutter/material.dart';
import 'package:fraudsense/core/utils/responsive.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 240, 179),
              border: Border.all(),
              borderRadius: BorderRadius.circular(5)),
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
