import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/models/level_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generated/levels_holder_model.g.dart';

@JsonSerializable()
class LevelsHolderModel {
  final List<LevelModel> levels;
  final AppLanguage language;

  LevelsHolderModel({required this.levels, required this.language});

  factory LevelsHolderModel.fromJson(Map<String, dynamic> json) =>
      _$LevelsHolderModelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelsHolderModelToJson(this);

  int getTotalScore() {
    int score = 0;

    for (var i = 0; i < levels.length; i++) {
      for (var j = 0; j < levels[i].scenarios.length; j++) {
        score += levels[i].scenarios[j].scoreGainedOnCompletion;
      }
    }

    return score;
  }
}
