import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fraudsense/core/sound/sound_manager.dart';
import 'package:fraudsense/generated/l10n.dart';
import 'package:fraudsense/models/answer_model.dart';
import 'package:fraudsense/providers/game_providers.dart';

class QuizBox extends StatefulWidget {
  const QuizBox(
      {super.key,
      required this.question,
      required this.answers,
      required this.onSubmit,
      required this.textDirection});

  final String question;
  final List<AnswerModel> answers;
  final void Function(AnswerModel) onSubmit;

  final TextDirection textDirection;

  @override
  State<QuizBox> createState() => _QuizBoxState();
}

class _QuizBoxState extends State<QuizBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          questionTextBox(widget.question, 70.0, 50.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  border: Border(top: BorderSide(color: Colors.grey.shade700, width: 2))),
              child: Column(
                children: [
                  answersList(widget.answers),
                  submitBox(onSubmit: widget.onSubmit),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget submitBox({required void Function(AnswerModel) onSubmit}) {
    return Consumer(builder: (context, ref, child) {
      final AnswerModel? selectedAnswer = ref.watch(selectedAnswerProvider);
      final bool? submittedAnswer = ref.watch(submittedAnswerProvider);

      MaterialStateProperty<Color?> buttonColor = (selectedAnswer == null)
          ? MaterialStatePropertyAll(Colors.grey.shade800)
          : MaterialStatePropertyAll(Colors.green.shade200);

      if (submittedAnswer != null) {
        buttonColor = MaterialStatePropertyAll(Colors.grey.shade800);
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
                style: ButtonStyle(backgroundColor: buttonColor),
                onPressed: () {
                  if (selectedAnswer != null) {
                    onSubmit(selectedAnswer);
                  }
                },
                child: Text(S.of(context).game_submitButton)),
          ),
        ],
      );
    });
  }

  Widget questionTextBox(String question, double maxHeight, double minHeight) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 70.0,
        minHeight: 40.0,
        minWidth: double.infinity,
      ),
      // margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 10) + const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      child: AutoSizeText(
        question,
        textAlign: TextAlign.center,
        // style: const TextStyle(fontSize: 15),
        maxFontSize: 15,
        minFontSize: 13,
        maxLines: 2,
        textDirection: widget.textDirection,
      ),
    );
  }

  Widget answerTextBox({required AnswerModel answerModel}) {
    return Consumer(builder: (context, ref, child) {
      final bool isSelected = identical(ref.watch(selectedAnswerProvider), answerModel);

      //this bool return true if the selected and submitted answer is true,
      //or false if its not. and if theres no submitted answer yet returns null
      final bool? submittedAnswer = ref.watch(submittedAnswerProvider);

      Color boxColor = isSelected ? Colors.black45 : Colors.grey.shade900;

      //if theres a submitted answer
      if (submittedAnswer != null) {
        //and if we were the selected answer which means we were submitted
        if (isSelected) {
          //we change the color if its the right answer or not
          if (submittedAnswer) {
            boxColor = Colors.green;
          } else {
            boxColor = Colors.red;
          }
        }
      }

      void onClick() {
        //no interaction if theres a submitted answer means this scenario is over
        if (submittedAnswer != null) return;

        SoundManager.instance.playSound("tab1");
        if (isSelected) {
          ref.read(selectedAnswerProvider.notifier).state = null;
        } else {
          ref.read(selectedAnswerProvider.notifier).state = answerModel;
        }
      }

      // return ShakeWidget(
      //   onController: (controller) {
      //     // if(controller.velocity)

      //   },
      //   duration: Duration(seconds: 1),
      //   shakeConstant: ShakeHorizontalConstant2(),
      //   autoPlay: true,
      //   child: Container(
      //     width: 200,
      //     height: 44,
      //     color: Colors.amber,
      //     alignment: Alignment.center,
      //     child: Text(
      //       ShakeHorizontalConstant1().runtimeType.toString(),
      //       style: const TextStyle(
      //           color: Colors.white, fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // );
      return SizedBox(
        width: 180,
        child: GestureDetector(
          onTap: onClick,
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade800, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  textDirection: widget.textDirection,
                  answerModel.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  maxFontSize: 12,
                  minFontSize: 10,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget answersList(List<AnswerModel> answers) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: answers.length,
        itemBuilder: (context, index) {
          return answerTextBox(
            answerModel: answers[index],
          );
        },
      ),
    );
  }
}
