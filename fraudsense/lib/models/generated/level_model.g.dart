// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelModel _$LevelModelFromJson(Map<String, dynamic> json) => LevelModel(
      index: (json['index'] as num).toInt(),
      description: json['description'] as String,
      scenarios: (json['scenarios'] as List<dynamic>)
          .map((e) => ScenarioModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LevelModelToJson(LevelModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'description': instance.description,
      'scenarios': instance.scenarios,
    };
