import 'package:calc/screens/home_vscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/home_bloc.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Demo calculator'),
    );
  }
}
