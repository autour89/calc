import 'package:calc/blocs/services/db_context_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class ServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DbContextService());
  }
}
