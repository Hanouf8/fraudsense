// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../levels_holder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LevelsHolderModel _$LevelsHolderModelFromJson(Map<String, dynamic> json) =>
    LevelsHolderModel(
      levels: (json['levels'] as List<dynamic>)
          .map((e) => LevelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: $enumDecode(_$AppLanguageEnumMap, json['language']),
    );

Map<String, dynamic> _$LevelsHolderModelToJson(LevelsHolderModel instance) =>
    <String, dynamic>{
      'levels': instance.levels,
      'language': _$AppLanguageEnumMap[instance.language]!,
    };

const _$AppLanguageEnumMap = {
  AppLanguage.ar: 'ar',
  AppLanguage.en: 'en',
};
