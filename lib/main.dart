import 'package:calc/blocs/bindings/home_binding.dart';
import 'package:calc/blocs/bindings/service_binding.dart';
import 'package:flutter/cupertino.dart';
import 'package:calc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
          binding: HomeBinding(),
        )
      ],
      initialBinding: ServiceBinding(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey[300],
          accentColor: Colors.grey[700],
          primaryTextTheme: TextTheme(
              headline1: GoogleFonts.aldrich(fontSize: 35, color: Colors.black),
              headline5: TextStyle(fontSize: 24, color: Colors.grey[300]))),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.grey[800],
          accentColor: Colors.grey[400],
          primaryTextTheme: TextTheme(
              headline1: GoogleFonts.aldrich(fontSize: 35, color: Colors.white),
              headline5: TextStyle(fontSize: 24, color: Colors.black))),
    );
  }
}
