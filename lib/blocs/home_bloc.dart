import 'package:calc/models/CalcModel.dart';
import 'package:flutter/cupertino.dart';

class HomeBloc with ChangeNotifier {
  String _operandOne = '', _operandTwo = '', _operaotor = '';
  String _outputText = '|';
  List<CalcModel> _models = [];

  String get outputText => _outputText;

  bool get _canCalc =>
      _operandOne.isNotEmpty && _operaotor.isNotEmpty && _operandTwo.isNotEmpty;

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
    var operandModels = [
      CalcModel(key: '-'),
      CalcModel(key: '+'),
      CalcModel(key: '*'),
      CalcModel(key: '/'),
      CalcModel(key: '='),
    ];

    _models..addAll(numModels)..addAll(operandModels);
  }

  void calc({CalcModel model}) {
    if (!_canCalc && model.value == '=') return;

    if (model.isOperator) {
      if (_canCalc) {
        switch (_operaotor) {
          case '-':
            _operandOne = _minus();
            break;
          case '+':
            _operandOne = _add();
            break;
          case '*':
            _operandOne = _multiple();
            break;
          default:
            _operandOne = _devide();
        }
        _operandTwo = '';
        _operaotor = '';
      } else
        _operaotor = model.value;
    } else {
      if (_operaotor.isEmpty) {
        _operandOne = '$_operandOne${model.value}';
      } else {
        _operandTwo = '$_operandTwo${model.value}';
      }
    }
    _outputText = '$_operandOne$_operaotor$_operandTwo|';
    notifyListeners();
  }

  String _add() => (int.parse(_operandOne) + int.parse(_operandTwo)).toString();
  String _minus() =>
      (int.parse(_operandOne) - int.parse(_operandTwo)).toString();
  String _multiple() =>
      (int.parse(_operandOne) * int.parse(_operandTwo)).toString();
  String _devide() =>
      (int.parse(_operandOne) / int.parse(_operandTwo)).toString();
}
