import 'package:calc/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/home_bloc.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeBloc()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.grey[300],
            accentColor: Colors.grey[700],
            primaryTextTheme: TextTheme(
                headline5: TextStyle(fontSize: 24, color: Colors.grey[300]))),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.grey[800],
            accentColor: Colors.grey[400],
            primaryTextTheme: TextTheme(
                headline5: TextStyle(fontSize: 24, color: Colors.black))),
        home: HomePage());
  }
}
