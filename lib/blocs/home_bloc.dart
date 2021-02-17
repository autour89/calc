import 'package:calc/models/ValueModel.dart';
import 'package:flutter/cupertino.dart';

class HomeBloc with ChangeNotifier {
  String operator;
  String value1, value2;
  List<ValueModel> _models;
  String _outputText = '|';

  HomeBloc() {
    _models = [
      ValueModel(isOperator: false, val: '1'),
      ValueModel(isOperator: false, val: '2'),
      ValueModel(isOperator: false, val: '3'),
      ValueModel(isOperator: false, val: '4'),
      ValueModel(isOperator: false, val: '5'),
      ValueModel(isOperator: false, val: '6'),
      ValueModel(isOperator: false, val: '7'),
      ValueModel(isOperator: false, val: '8'),
      ValueModel(isOperator: false, val: '9'),
      ValueModel(isOperator: false, val: '0'),
      ValueModel(isOperator: true, val: '-'),
      ValueModel(isOperator: true, val: '+'),
      ValueModel(isOperator: true, val: '*'),
      ValueModel(isOperator: true, val: '/'),
      ValueModel(isOperator: true, val: '='),
    ];
  }

  List<ValueModel> get models => _models;
  String get outputText => _outputText;

  void onAddValue(ValueModel model) {
    if (!model.isOperator) {
      _outputText = _outputText + model.val;
      notifyListeners();
    }
  }
}
