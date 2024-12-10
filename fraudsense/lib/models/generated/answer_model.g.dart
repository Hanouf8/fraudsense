// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) => AnswerModel(
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
      explanationWhenIncorrect: json['explanationWhenIncorrect'] as String,
    );

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'isCorrect': instance.isCorrect,
      'explanationWhenIncorrect': instance.explanationWhenIncorrect,
    };
