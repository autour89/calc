import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/iterables.dart';
import '../blocs/home_bloc.dart';
import '../screens/styles/extensions.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HomeBloc>();
    return Scaffold(
        backgroundColor: Colors.grey[310],
        body: SafeArea(
            child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        child: Text(
                          context.watch<HomeBloc>().outputText,
                          style: TextStyle(fontSize: 30),
                        ),
                      )),
                  color: Colors.transparent)),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  ...partition(bloc.models, 3).map((e) => Expanded(
                        child: Row(
                          children: [
                            ...e.map(
                              (e) => Expanded(
                                  child: Container(
                                margin: EdgeInsets.all(3),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: () => bloc.calc(model: e),
                                  child: Center(
                                    child: Text(
                                      e.value,
                                      style: TextStyle(fontSize: 26),
                                    ),
                                  ),
                                ),
                              )),
                            )
                          ],
                        ),
                      ))
                ],
              ))
        ])));
  }
}
