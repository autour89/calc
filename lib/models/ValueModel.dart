import 'package:flutter/foundation.dart';

class ValueModel {
  dynamic val;
  Function calculationFunc;

  String get value => val.toString();

  bool get isOperand => num.tryParse(val) != null && val.toString() != '=';

  ValueModel({@required this.val, Function calculationFunc});
}
