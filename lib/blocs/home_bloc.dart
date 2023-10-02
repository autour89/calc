import 'package:calc/models/calc_model.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:quiver/iterables.dart';

class HomeBloc extends GetxController {
  final RxList<CalcModel> _calculations = RxList<CalcModel>.empty();
  final List<CalcModel> _models = [];
  final RegExp _expression = RegExp(r'^(\d?|0[.]\d*|[1-9][0-9]*[.]?\d*)$');
  final Parser _parser = Parser();

  String get output => _calculations.map((e) => e.value).join();

  List<CalcModel> get models => _models;

  /// Get only operators / commands
  Iterable<CalcModel> get functions => _models.where(
      (element) => element.isOperator && element.command != Command.equal);

  /// Get only numbers and equal command(why equal sign is here?)
  Iterable<List<CalcModel>> get operands => partition(
      _models.where((element) =>
          element.command == Command.non || element.command == Command.equal), 3);

  bool get _canCalc =>
      _calculations.any((element) => element.leftOperand == false) &&
          _operatorSet;

  bool get _operatorSet =>
      _calculations.any((element) => element.command != Command.non);

  HomeBloc() {
    _init();
  }

  /// calculate input
  void calculate({required CalcModel model}) {
    if (model.command == Command.reset) {
      _calculations.clear();
    } else if (model.command == Command.edit) {
      _calculations.removeLast();
    } else if (model.isOperator) {
      if (_canCalc) {
        _evaluate(model);
      } else {
        if (model.command != Command.equal && _calculations.isNotEmpty) {
          if (_operatorSet) _calculations.removeLast();
          _calculations.add(CalcModel(key: model.value));
        }
      }
    } else {
      if (!_isValid(model)) return;
      _calculations.add(
          CalcModel(key: model.key, leftOperand: !_operatorSet));
    }
  }

  bool _isValid(CalcModel model) {
    var maxLength = 15;
    var input = _calculations
        .where((c) => c.leftOperand == !_operatorSet)
        .map((c) => c.value)
        .join() +
        model.value;

    return input.length <= maxLength && _expression.hasMatch(input);
  }

  void _evaluate(CalcModel model) {
    var result = double.tryParse(_parser
        .parse(output)
        .evaluate(EvaluationType.REAL, ContextModel())
        .toString());

    _calculations.clear();
    if (result != null &&
        result != double.infinity &&
        result != double.negativeInfinity &&
        result != double.maxFinite &&
        result != double.minPositive) {
      var integer = result.toInt();
      _calculations.add(CalcModel(
          key: result - integer != 0.0 ? result : integer, leftOperand: true));
      if (model.command != Command.equal) {
        _calculations.add(CalcModel(key: model.value));
      }
    }
  }

  void _init() async {
    _models
      ..addAll([
        for (var i = 7; i >= 0; i--) CalcModel(key: i),
      ])
      ..addAll([
        CalcModel(key: '.'),
        CalcModel(key: '-'),
        CalcModel(key: '+'),
        CalcModel(key: '*'),
        CalcModel(key: '/'),
        CalcModel(key: 'X'),
        CalcModel(key: 'C'),
        CalcModel(key: '='),
      ]);
  }
}
