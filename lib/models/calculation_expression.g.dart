// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculation_expression.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalculationExpressionAdapter extends TypeAdapter<CalculationExpression> {
  @override
  final int typeId = 0;

  @override
  CalculationExpression read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculationExpression(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CalculationExpression obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.expression)
      ..writeByte(1)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationExpressionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
