class CalcModel {
  String operandOne, operandTwo, _operaotor;
  String calculationResult;

  void _add() => calculationResult =
      (double.parse(operandOne) + double.parse(operandTwo)).toString();
  void _minus() => calculationResult =
      (double.parse(operandOne) - double.parse(operandTwo)).toString();
  void _multiple() => calculationResult =
      (double.parse(operandOne) * double.parse(operandTwo)).toString();
  void _devide() => calculationResult =
      (double.parse(operandOne) / double.parse(operandTwo)).toString();

  void equals({String val}) {
    if (num.tryParse(val) != null) {
      if (_operaotor.isEmpty) {
        operandOne = '$operandOne$val';
      } else {
        operandTwo = '$operandTwo$val';
      }
      return;
    }

    if (!canCalc && val.isEmpty) {
      _operaotor = val;
      return;
    }

    switch (_operaotor) {
      case '-':
        _minus();
        break;
      case '+':
        _add();
        break;
      case '*':
        _multiple();
        break;
      default:
        _devide();
    }
    _operaotor = '';
  }

  bool get canCalc => !(operandOne.isEmpty || operandTwo.isEmpty);
}
