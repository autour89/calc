import 'package:calc/blocs/home_bloc.dart';
import 'package:calc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          binding: HomeBinding(),
        )
      ],
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey[300],
          secondaryHeaderColor: Colors.grey[700],
          primaryTextTheme: TextTheme(
              headline1: GoogleFonts.poppins(fontSize: 60, color: Colors.black),
              headline5: TextStyle(fontSize: 24, color: Colors.grey[300]))),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey[800],
          secondaryHeaderColor: Colors.grey[400],
          primaryTextTheme: TextTheme(
              headline1: GoogleFonts.poppins(fontSize: 60, color: Colors.white),
              headline5: const TextStyle(fontSize: 24, color: Colors.black))),
    );
  }
}

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeBloc>(() => HomeBloc());
  }
}