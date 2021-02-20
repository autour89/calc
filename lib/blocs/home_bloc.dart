import 'package:calc/models/CalcModel.dart';
import 'package:calc/models/ValueModel.dart';
import 'package:flutter/cupertino.dart';

class HomeBloc with ChangeNotifier {
  CalcModel _calcModel;
  String _outputText = '|';
  List<ValueModel> _models;

  String get outputText => _outputText;

  HomeBloc() {
    _calcModel = CalcModel();
    _models = [];

    var valueModels = [
      ValueModel(val: 1, calculationFunc: () => _calcModel.equals(val: '1')),
      ValueModel(val: 2, calculationFunc: () => _calcModel.equals(val: '2')),
      ValueModel(val: 3, calculationFunc: () => _calcModel.equals(val: '3')),
      ValueModel(val: 4, calculationFunc: () => _calcModel.equals(val: '4')),
      ValueModel(val: 5, calculationFunc: () => _calcModel.equals(val: '5')),
      ValueModel(val: 6, calculationFunc: () => _calcModel.equals(val: '6')),
      ValueModel(val: 7, calculationFunc: () => _calcModel.equals(val: '7')),
      ValueModel(val: 8, calculationFunc: () => _calcModel.equals(val: '8')),
      ValueModel(val: 9, calculationFunc: () => _calcModel.equals(val: '9')),
      ValueModel(val: 0, calculationFunc: () => _calcModel.equals(val: '0')),
    ];
    var operandModels = [
      ValueModel(val: '-', calculationFunc: () => _calcModel.equals(val: '-')),
      ValueModel(val: '+', calculationFunc: () => _calcModel.equals(val: '+')),
      ValueModel(val: '*', calculationFunc: () => _calcModel.equals(val: '*')),
      ValueModel(val: '/', calculationFunc: () => _calcModel.equals(val: '/')),
      ValueModel(val: '=', calculationFunc: () => _calcModel.equals()),
    ];

    _models..addAll(valueModels)..addAll(operandModels);
  }

  List<ValueModel> get models => _models;

  void onAddValue(ValueModel model) {
    if (model.isOperand) {
      model.calculationFunc();
      if (_calcModel.canCalc) _outputText = '${_calcModel.calculationResult}|';
    } else {}
    notifyListeners();
  }

  void updateCalc(Function func) {}
}
