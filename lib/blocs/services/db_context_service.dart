import 'package:calc/blocs/services/I_data_service.dart';
import 'package:calc/models/calculation_expression.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbContextService extends GetxService implements IDataService {
  DbContextService();

  static Future initContext = Future(() async {
    await Hive.initFlutter();
    await Hive.openBox('testBox');
    Hive.registerAdapter<CalculationExpression>(CalculationExpressionAdapter());
  });

  @override
  Future<void> update() async {
    var box = Hive.box('testBox');
    box.put('name', 'David');
    var result = box.get('name');
    print('Name: $result');
  }
}
