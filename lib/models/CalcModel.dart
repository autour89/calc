import 'package:flutter/foundation.dart';

class CalcModel {
  dynamic key;

  String get value => key.toString();

  bool get isOperator => num.tryParse(key.toString()) == null;

  CalcModel({@required this.key});
}
