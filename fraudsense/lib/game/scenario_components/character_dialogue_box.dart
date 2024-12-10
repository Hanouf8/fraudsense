import 'package:flutter/material.dart';
import 'package:fraudsense/core/utils/text_utilities.dart';
import 'package:fraudsense/game/scenario_components/character_text_box.dart';
import 'package:fraudsense/generated/l10n.dart';

//this shows a dialogue box with the character, allowing for big text to be displayed
//in sections
class CharacterDialogueBox extends StatefulWidget {
  const CharacterDialogueBox(
      {super.key,
      required this.textDirection,
      required this.fullDialogueText,
      this.maxTextLengthPerSlide = 100,
      required this.onExit});

  final TextDirection textDirection;
  final String fullDialogueText;
  final int maxTextLengthPerSlide;
  final VoidCallback onExit;

  @override
  State<CharacterDialogueBox> createState() => _CharacterDialogueBoxState();
}

class _CharacterDialogueBoxState extends State<CharacterDialogueBox> {
  int currentSlideIndex = 0;
  late List<String> dialogueList;

  //we cut the full text into sections to fit the dialogue window
  @override
  void initState() {
    dialogueList = TextUtilities.cutTextIntoList(
        text: widget.fullDialogueText, maxLength: widget.maxTextLengthPerSlide);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String message = dialogueList[currentSlideIndex];

    return Container(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: widget.onExit,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CharacterTextBox(
                message: message,
                showMessage: true,
                imagePath: "assets/images/character/character_speak.png",
                textDirection: widget.textDirection,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (currentSlideIndex != 0)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (currentSlideIndex != 0) {
                            currentSlideIndex--;
                          }
                        });
                      },
                      child: Text(S.of(context).previousButton)),
                const SizedBox(width: 50),
                if (currentSlideIndex != dialogueList.length - 1)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (currentSlideIndex != (dialogueList.length - 1)) {
                            currentSlideIndex++;
                          }
                        });
                      },
                      child: Text(S.of(context).nextButton))
              ],
            )
          ],
        ),
      ),
    );
  }
}
