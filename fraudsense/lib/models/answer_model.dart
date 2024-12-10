import 'package:json_annotation/json_annotation.dart';

part 'generated/answer_model.g.dart';

@JsonSerializable()
class AnswerModel {
  final String text;
  final bool isCorrect;
  final String explanationWhenIncorrect;

  const AnswerModel(
      {required this.text,
      required this.isCorrect,
      required this.explanationWhenIncorrect});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
