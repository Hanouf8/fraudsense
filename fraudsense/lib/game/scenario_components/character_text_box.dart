import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CharacterTextBox extends StatefulWidget {
  const CharacterTextBox(
      {super.key,
      required this.message,
      required this.showMessage,
      this.onCharacterClick,
      this.onMessageBoxClick,
      required this.imagePath,
      required this.textDirection});

  final String message;
  final bool showMessage;
  final VoidCallback? onCharacterClick;
  final VoidCallback? onMessageBoxClick;

  final String imagePath;

  final TextDirection textDirection;

  @override
  State<CharacterTextBox> createState() => _ExplanationCharacterState();
}

class _ExplanationCharacterState extends State<CharacterTextBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.ltr,
        // dir
        children: [
          Expanded(child: messageBox(widget.showMessage)),
          const SizedBox(width: 10),
          // characterImage(),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, left: 4.0, top: 4.0),
            child: characterImage(),
          )
        ],
      ),
    );
  }

  Widget messageBox(bool display) {
    return Visibility(
      visible: display,
      child: GestureDetector(
        onTap: widget.onMessageBoxClick,
        child: Container(
          // margin: const EdgeInsets.only(left: 25),
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minWidth: 5.0, maxWidth: 300.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            color: const Color.fromARGB(121, 195, 226, 247),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(0),
            ),
          ),

          child: AutoSizeText(
            textAlign: TextAlign.center,
            textDirection: widget.textDirection,
            widget.message,
            minFontSize: 10,
            maxFontSize: 12,
            style: const TextStyle(fontSize: 12, color: Colors.white),
            maxLines: 5,
          ),
        ),
      ),
    );
  }

  Widget characterImage() {
    return GestureDetector(
      onTap: widget.onCharacterClick,
      child: Container(
        child: Transform.flip(
          child: Image.asset(
            widget.imagePath,
          ),
        ),
      ),
    );
  }
}
