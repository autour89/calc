import 'package:calc/blocs/home_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeBloc>(() => HomeBloc());
  }
}
