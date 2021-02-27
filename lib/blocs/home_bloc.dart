import 'package:calc/models/CalcModel.dart';
import 'package:flutter/foundation.dart';

class HomeBloc with ChangeNotifier {
  String _outputText = '|';
  List<CalcModel> _calculations = [];
  List<CalcModel> _models = [];

  String get outputText => _outputText;

  bool get _canCalc =>
      _calculations
          .where((element) => element.leftOperand)
          .isNotEmpty &&
          _calculations
              .where((element) => element.command != null)
              .isNotEmpty &&
          _calculations
              .where((element) =>
          element.leftOperand == false && element.command == null)
              .isNotEmpty;

  bool get _isOperatorSet =>
      _calculations
          .where((element) => element.command != null)
          .isNotEmpty;

  List<CalcModel> get models => _models;

  HomeBloc() {
    var numModels = [
      CalcModel(key: 1),
      CalcModel(key: 2),
      CalcModel(key: 3),
      CalcModel(key: 4),
      CalcModel(key: 5),
      CalcModel(key: 6),
      CalcModel(key: 7),
      CalcModel(key: 8),
      CalcModel(key: 9),
      CalcModel(key: 0),
    ];
    var operatorModels = [
      CalcModel(key: '-'),
      CalcModel(key: '+'),
      CalcModel(key: '*'),
      CalcModel(key: '/'),
      CalcModel(key: '='),
      CalcModel(key: 'CE'),
      CalcModel(key: 'X'),
    ];
    _models..addAll(numModels)..addAll(operatorModels);
  }

  void calc({CalcModel model}) {
    if (model.command == Command.reset) {
      _calculations.clear();
    } else if (model.command == Command.edit)
      _removeLastInput();
    else if (model.isOperator) {
      _processOperator(model);
    } else {
      _calculations.add(
          CalcModel(key: model.key, leftOperand: _isOperatorSet ? false : true));
    }
    _updateOutput();
  }

  String _add() =>
      (int.parse(_operandsToValue(leftOperand: true)) +
          int.parse(_operandsToValue()))
          .toString();

  String _minus() =>
      (int.parse(_operandsToValue(leftOperand: true)) -
          int.parse(_operandsToValue()))
          .toString();

  String _multiple() =>
      (int.parse(_operandsToValue(leftOperand: true)) *
          int.parse(_operandsToValue()))
          .toString();

  String _divide() =>
      (int.parse(_operandsToValue(leftOperand: true)) /
          int.parse(_operandsToValue()))
          .toString();

  void _updateOutput() {
    //concatenate data into string
    _outputText =
    '${_operandsToValue(
        leftOperand: true)}${_operatorToString()}${_operandsToValue()}|';
    notifyListeners();
  }

  void _processOperator(CalcModel model) {
    //calculate data or set operator
    if (_canCalc) {
      String result;
      switch (_calculations
          .firstWhere((element) => element.command != null)
          .command) {
        case Command.minus:
          result = _minus();
          break;
        case Command.add:
          result = _add();
          break;
        case Command.multiple:
          result = _multiple();
          break;
        default:
          result = _divide();
      }
      _calculations.clear();
      _calculations.add(CalcModel(key: result, leftOperand: true));
    } else {
      if (model.command != Command.equal &&
          _calculations
              .where((element) => element.leftOperand)
              .isNotEmpty) {
        _calculations.removeWhere((element) => element.command != null);
        _calculations.add(CalcModel(key: model.value, command: model.command));
      }
    }
  }

  void _removeLastInput() {
    //identify where from to remove last element
    _calculations
        .where((element) => !element.leftOperand)
        .isNotEmpty
        ? _calculations
        .remove(_calculations.lastWhere((element) => !element.leftOperand))
        : _calculations
        .where((element) => element.command != null)
        .isNotEmpty
        ? _calculations.remove(
        _calculations.lastWhere((element) => element.command != null))
        : _calculations
        .where((element) => element.leftOperand)
        .isNotEmpty
        ? _calculations.remove(
        _calculations.lastWhere((element) => element.leftOperand))
        : {};
  }

  String _operatorToString() {
    //map operator to string
    return _isOperatorSet ? _calculations
        .firstWhere((element) => element.command != null)
        .value : '';
  }

  String _operandsToValue({bool leftOperand = false}) =>
      _calculations
          .where((element) => element.leftOperand == leftOperand)
          .map((e) => e.value)
          .join();
}
