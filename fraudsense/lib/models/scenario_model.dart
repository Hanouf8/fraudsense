import 'package:fraudsense/models/answer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/scenario_model.g.dart';

@JsonSerializable()
class ScenarioModel {
  @JsonKey(defaultValue: "")
  final String startingCharacterMessage;
  final String contactTitle;
  final String receivedMessage;
  final String receivedLink;

  @JsonKey(defaultValue: false)
  final bool isVerifiedContact;
  final String messageTime;

  final String question;
  final List<AnswerModel> answers;
  final String hint;

  final int timeToSolveInSeconds;
  final int scoreGainedOnCompletion;

  const ScenarioModel(
      {required this.startingCharacterMessage,
      required this.contactTitle,
      required this.receivedMessage,
      required this.receivedLink,
      required this.isVerifiedContact,
      required this.messageTime,
      required this.question,
      required this.answers,
      required this.hint,
      required this.timeToSolveInSeconds,
      required this.scoreGainedOnCompletion});

  factory ScenarioModel.fromJson(Map<String, dynamic> json) => _$ScenarioModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScenarioModelToJson(this);

  ScenarioModel copyWith({
    String? startingCharacterMessage,
    String? contactTitle,
    String? receivedMessage,
    String? receivedLink,
    bool? isVerifiedContact,
    String? messageTime,
    String? question,
    List<AnswerModel>? answers,
    String? hint,
    int? timeToSolveInSeconds,
    int? scoreGainedOnCompletion,
  }) {
    return ScenarioModel(
      startingCharacterMessage: startingCharacterMessage ?? this.startingCharacterMessage,
      contactTitle: contactTitle ?? this.contactTitle,
      receivedMessage: receivedMessage ?? this.receivedMessage,
      receivedLink: receivedLink ?? this.receivedLink,
      isVerifiedContact: isVerifiedContact ?? this.isVerifiedContact,
      messageTime: messageTime ?? this.messageTime,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      hint: hint ?? this.hint,
      timeToSolveInSeconds: timeToSolveInSeconds ?? this.timeToSolveInSeconds,
      scoreGainedOnCompletion: scoreGainedOnCompletion ?? this.scoreGainedOnCompletion,
    );
  }

  static ScenarioModel placeholderData() {
    return const ScenarioModel(
        startingCharacterMessage: "starting character message",
        answers: [
          AnswerModel(text: "answer 1", isCorrect: true, explanationWhenIncorrect: "explanation")
        ],
        receivedMessage: "received message",
        receivedLink: "www.example.come",
        hint: "hint",
        timeToSolveInSeconds: 20,
        question: "question",
        scoreGainedOnCompletion: 10,
        contactTitle: "+123 45 678 90",
        isVerifiedContact: false,
        messageTime: "10:00 AM");
  }
}
