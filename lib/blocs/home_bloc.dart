import 'package:calc/models/CalcModel.dart';
import 'package:flutter/foundation.dart';

class HomeBloc with ChangeNotifier {
  String _outputText = '|';
  Command _operator = Command.non;
  List<CalcModel> _operands = [];
  List<CalcModel> _models = [];

  String get outputText => _outputText;

  bool get _canCalc =>
      _operands.where((element) => element.leftOperand).isNotEmpty &&
      _operator != Command.non &&
      _operands.where((element) => !element.leftOperand).isNotEmpty;

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
      _operator = Command.non;
      _operands.clear();
    } else if (model.command == Command.edit)
      _removeLastInput();
    else if (model.isOperator) {
      if (_canCalc) {
        String result;
        switch (_operator) {
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
        _operands.clear();
        _operator = Command.non;
        _operands.add(CalcModel(key: result, leftOperand: true));
      } else {
        _operator = model.command != Command.equal ? model.command : {};
      }
    } else {
      var operandModel = CalcModel(
          key: model.key, leftOperand: _operator == Command.non ? true : false);
      _operands.add(operandModel);
    }
    _updateOutput();
  }

  String _add() => (int.parse(_operandsToValue(leftOperand: true)) +
          int.parse(_operandsToValue()))
      .toString();

  String _minus() => (int.parse(_operandsToValue(leftOperand: true)) -
          int.parse(_operandsToValue()))
      .toString();

  String _multiple() => (int.parse(_operandsToValue(leftOperand: true)) *
          int.parse(_operandsToValue()))
      .toString();

  String _divide() => (int.parse(_operandsToValue(leftOperand: true)) /
          int.parse(_operandsToValue()))
      .toString();

  void _updateOutput() {
    _outputText =
        '${_operandsToValue(leftOperand: true)}${_operatorToString()}${_operandsToValue()}|';
    notifyListeners();
  }

  void _removeLastInput() {
    _operands.where((element) => !element.leftOperand).isNotEmpty
        ? _operands
            .remove(_operands.where((element) => !element.leftOperand).last)
        : _operator != Command.non
            ? _operator = Command.non
            : _operands.where((element) => element.leftOperand).isNotEmpty
                ? _operands.remove(
                    _operands.where((element) => element.leftOperand).last)
                : {};
  }

  String _operatorToString() {
    switch (_operator) {
      case Command.minus:
        return '-';
      case Command.add:
        return '+';
      case Command.multiple:
        return '*';
      case Command.divide:
        return '/';
      default:
        return '';
    }
  }

  String _operandsToValue({bool leftOperand = false}) => _operands
      .where((element) => element.leftOperand == leftOperand)
      .map((e) => e.value)
      .join();
}
