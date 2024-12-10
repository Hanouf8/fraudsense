import 'package:fraudsense/models/answer_model.dart';
import 'package:fraudsense/models/scenario_model.dart';

class UnsolvedScenariosModel {
  //this is null when the timer runs out and the user couldn't pick an answer
  final AnswerModel? pickedAnswer;
  final ScenarioModel scenarioModel;

  UnsolvedScenariosModel(
      {required this.pickedAnswer, required this.scenarioModel});
}
