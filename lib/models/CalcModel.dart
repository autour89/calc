import 'package:flutter/foundation.dart';

enum Command { non, add, minus, multiple, divide, equal, edit, reset }

class CalcModel {
  dynamic key;
  Command _command = Command.non;
  bool leftOperand = false;

  CalcModel({@required this.key, this.leftOperand}) {
    _mapToCommand();
  }

  String get value => key.toString();

  Command get command => _command;

  bool get isOperator => num.tryParse(value) == null;

  void _mapToCommand() {
    if (isOperator) {
      switch (value) {
        case '-':
          _command = Command.minus;
          break;
        case '+':
          _command = Command.add;
          break;
        case '*':
          _command = Command.multiple;
          break;
        case '/':
          _command = Command.divide;
          break;
        case '=':
          _command = Command.equal;
          break;
        case 'X':
          _command = Command.edit;
          break;
        default:
          _command = Command.reset;
          break;
      }
    }
  }
}
