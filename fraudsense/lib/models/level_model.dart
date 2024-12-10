import 'package:fraudsense/models/scenario_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/level_model.g.dart';

@JsonSerializable()
class LevelModel {
  final int index;
  final String description;
  final List<ScenarioModel> scenarios;

  LevelModel({required this.index, required this.description, required this.scenarios});

  factory LevelModel.fromJson(Map<String, dynamic> json) => _$LevelModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelModelToJson(this);
}
