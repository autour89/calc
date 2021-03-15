import 'package:hive/hive.dart';

part 'calculation_expression.g.dart';

@HiveType(typeId: 0)
class CalculationExpression {
  @HiveField(0)
  String expression;
  @HiveField(1)
  String result;

  CalculationExpression(this.expression,this.result);
}
