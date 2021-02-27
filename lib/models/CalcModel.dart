import 'package:flutter/foundation.dart';

enum Command { non, add, minus, multiple, divide, equal, edit, reset }

class CalcModel {
  dynamic key;
  Command command = Command.non;
  bool leftOperand;

  CalcModel({@required this.key, this.leftOperand, this.command}) {
    _mapToCommand();
  }

  String get value => key.toString();

  bool get isOperator => num.tryParse(value) == null;

  void _mapToCommand() {
    if (isOperator) {
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
        default:
          command = Command.reset;
          break;
      }
    }
  }
}
