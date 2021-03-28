import 'package:flutter/foundation.dart';

enum Command { non, equal, edit, reset, minus, add, multiple, divide }

class CalcModel {
  dynamic key;
  Command command;
  bool leftOperand;

  CalcModel({@required this.key, this.leftOperand}) {
    _mapToCommand();
  }

  String get value => key.toString();

  bool get isOperator => num.tryParse(value) == null && !isFloat;

  bool get isFloat => value == '.';

  void _mapToCommand() {
    switch (value) {
      case '-':
        command = Command.minus;
        break;
      case '+':
        command = Command.add;
        break;
      case '*':
        command = Command.multiple;
        break;
      case '/':
        command = Command.divide;
        break;
      case '=':
        command = Command.equal;
        break;
      case 'X':
        command = Command.edit;
        break;
      case 'C':
        command = Command.reset;
        break;
      default:
        command = Command.non;
        break;
    }
  }
}
