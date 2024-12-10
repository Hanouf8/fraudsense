// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../scenario_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScenarioModel _$ScenarioModelFromJson(Map<String, dynamic> json) =>
    ScenarioModel(
      startingCharacterMessage:
          json['startingCharacterMessage'] as String? ?? '',
      contactTitle: json['contactTitle'] as String,
      receivedMessage: json['receivedMessage'] as String,
      receivedLink: json['receivedLink'] as String,
      isVerifiedContact: json['isVerifiedContact'] as bool? ?? false,
      messageTime: json['messageTime'] as String,
      question: json['question'] as String,
      answers: (json['answers'] as List<dynamic>)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      hint: json['hint'] as String,
      timeToSolveInSeconds: (json['timeToSolveInSeconds'] as num).toInt(),
      scoreGainedOnCompletion: (json['scoreGainedOnCompletion'] as num).toInt(),
    );

Map<String, dynamic> _$ScenarioModelToJson(ScenarioModel instance) =>
    <String, dynamic>{
      'startingCharacterMessage': instance.startingCharacterMessage,
      'contactTitle': instance.contactTitle,
      'receivedMessage': instance.receivedMessage,
      'receivedLink': instance.receivedLink,
      'isVerifiedContact': instance.isVerifiedContact,
      'messageTime': instance.messageTime,
      'question': instance.question,
      'answers': instance.answers,
      'hint': instance.hint,
      'timeToSolveInSeconds': instance.timeToSolveInSeconds,
      'scoreGainedOnCompletion': instance.scoreGainedOnCompletion,
    };
