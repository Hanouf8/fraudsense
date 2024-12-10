//class handling level importing and exporting in json

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/core/utils/result.dart';
import 'package:fraudsense/models/levels_holder_model.dart';

class LevelIO {
  static void logToJson(LevelsHolderModel levelsModel) {
    final jsonString = jsonEncode(levelsModel.toJson());

    log(jsonString);
  }

  static Future<LevelsHolderModel> getLocalizedLevels(
    AppLanguage language,
  ) async {
    Result result;

    switch (language) {
      case AppLanguage.en:
        result = await importFromFile('assets/levels/levels_en.json');
        break;
      case AppLanguage.ar:
        result = await importFromFile('assets/levels/levels_ar.json');
        break;
    }

    if (!result.isSuccess) {
      throw Exception(result.error);
    }

    return result.data;
  }

  static Future<Result<LevelsHolderModel>> importFromFile(String filePath) async {
    try {
      String jsonString = await rootBundle.loadString(filePath);

      Map<String, dynamic> parsedJson = jsonDecode(jsonString);

      return Result(data: LevelsHolderModel.fromJson(parsedJson));
    } catch (e) {
      return Result(error: e.toString());
    }
  }
}
