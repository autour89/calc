import 'package:calc/models/CalcModel.dart';
import 'package:flutter/foundation.dart';

class HomeBloc with ChangeNotifier {
  List<CalcModel> _calculations = [];
  List<CalcModel> _models = [];
  RegExp _expression = RegExp(r'^(\d?|[0][.]\d*|[1-9][0-9]*[.]?\d*)$');

  String get output => '${_calculations.map((e) => e.value).join()}|';

  List<CalcModel> get models => _models;

  bool get _cantCalc =>
      _calculations.where((element) => element.leftOperand == false).isEmpty ||
      _operatorSet == false ||
      _calculations.where((element) => element.leftOperand).isEmpty;

  bool get _operatorSet =>
      _calculations.where((element) => element.command != null).isNotEmpty;

  HomeBloc() {
    _init();
  }

  void calc({CalcModel model}) {
    if (model.command == Command.reset) {
      _calculations.clear();
    } else if (model.command == Command.edit)
      _calculations.removeLast();
    else if (model.isOperator) {
      _processOperator(model);
    } else {
      if (!_isValid(model)) return;
      _calculations.add(
          CalcModel(key: model.key, leftOperand: _operatorSet ? false : true));
    }
    notifyListeners();
  }

  bool _isValid(CalcModel model) {
    //validate input form
    var maxLength = 15;
    var input =
        _mapToValue(leftOperand: _operatorSet ? false : true) + model.value;

    return input.length <= maxLength && _expression.hasMatch(input);
  }

  String _add() =>
      (double.parse(_mapToValue(leftOperand: true)) + double.parse(_mapToValue()))
          .toString();

  String _minus() =>
      (double.parse(_mapToValue(leftOperand: true)) - double.parse(_mapToValue()))
          .toString();

  String _multiple() =>
      (double.parse(_mapToValue(leftOperand: true)) * double.parse(_mapToValue()))
          .toString();

  String _divide() =>
      (double.parse(_mapToValue(leftOperand: true)) / double.parse(_mapToValue()))
          .toString();

  void _processOperator(CalcModel model) {
    //calculate data or set operator
    if (_cantCalc) {
      if (model.command != Command.equal &&
          _calculations.where((element) => element.leftOperand).isNotEmpty) {
        _calculations.removeWhere((element) => element.command != null);
        _calculations.add(CalcModel(key: model.value));
      }
    } else {
      String result;
      var command = _calculations
          .firstWhere((element) => element.command != null)
          .command;
      switch (command) {
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
      if (model.command != Command.equal) {
        _calculations.add(CalcModel(key: model.value));
      }
    }
  }

  String _mapToValue({bool leftOperand = false}) {
    //map operands to string
    return _calculations
        .where((element) => element.leftOperand == leftOperand)
        .map((e) => e.value)
        .join();
  }

  void _init() {
    var numbs = [
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
      CalcModel(key: '.'),
    ];
    var operators = [
      CalcModel(key: '-'),
      CalcModel(key: '+'),
      CalcModel(key: '*'),
      CalcModel(key: '/'),
      CalcModel(key: 'CE'),
      CalcModel(key: 'X'),
      CalcModel(key: '='),
    ];
    _models..addAll(numbs)..addAll(operators);
  }
}
