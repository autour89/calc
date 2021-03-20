import 'package:calc/blocs/services/I_data_service.dart';
import 'package:calc/blocs/services/db_context_service.dart';
import 'package:calc/models/calc_model.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeBloc extends GetxController {
  IDataService _dataService;
  RxList<CalcModel> _calculations = RxList.empty();
  List<CalcModel> _models = [];
  RegExp _expression = RegExp(r'^(\d?|[0][.]\d*|[1-9][0-9]*[.]?\d*)$');
  Parser _parser = Parser();

  String get output => _calculations.map((e) => e.value).join();

  List<CalcModel> get models => _models;

  bool get _cantCalc =>
      _calculations.where((element) => element.leftOperand == false).isEmpty ||
      _operatorSet == false ||
      _calculations.where((element) => element.leftOperand).isEmpty;

  bool get _operatorSet => _calculations
      .where((element) => element.command != Command.non)
      .isNotEmpty;

  HomeBloc() {
    _init();
  }


  Future<bool> appStart() async {
    // await Future.delayed(Duration(seconds: 2));
    await DbContextService.initContext;

    return true;
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
  }

  bool _isValid(CalcModel model) {
    //validate input form
    var maxLength = 15;
    var filter = _operatorSet ? false : true;
    var input = _calculations
            .where((c) => c.leftOperand == filter)
            .map((c) => c.value)
            .join() +
        model.value;

    return input.length <= maxLength && _expression.hasMatch(input);
  }

  void _processOperator(CalcModel model) {
    //calculate data or set operator
    if (_cantCalc) {
      if (model.command != Command.equal &&
          !_operatorSet &&
          _calculations.length > 0) {
        _calculations.add(CalcModel(key: model.value));
      }
    } else {
      var result =
          _parser.parse(output).evaluate(EvaluationType.REAL, ContextModel());
      _calculations.clear();
      _calculations.add(CalcModel(key: result, leftOperand: true));
      if (model.command != Command.equal) {
        _calculations.add(CalcModel(key: model.value));
      }
    }
  }

  void _init() async {
    _dataService = Get.find<DbContextService>();
    _models
      ..addAll([
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
      ])
      ..addAll([
        CalcModel(key: '-'),
        CalcModel(key: '+'),
        CalcModel(key: '*'),
        CalcModel(key: '/'),
        CalcModel(key: 'CE'),
        CalcModel(key: 'X'),
        CalcModel(key: '='),
      ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
