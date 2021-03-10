import 'package:flutter/foundation.dart';

enum Command { non, equal, edit, reset}

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
    if (isOperator) {
      switch (value) {
        case '=':
          command = Command.equal;
          break;
        case 'X':
          command = Command.edit;
          break;
        case 'CE':
          command = Command.reset;
          break;
        default:
          command = Command.non;
          break;
      }
    }
  }
}
