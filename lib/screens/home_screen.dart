import 'package:calc/screens/widgets/CalcButton.dart';
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
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Column(children: [
          Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        child: Text(
                          context.watch<HomeBloc>().output,
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      )),
                  color: Colors.transparent)),
          Expanded(
              flex: 3,
              child: Center(
                  child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 400, maxWidth: 350),
                child: Column(
                  children: [
                    ...partition(context.read<HomeBloc>().models, 3)
                        .map((iterable) => Expanded(
                              child: Row(
                                children: [
                                  ...iterable.map((model) => CalcButton(
                                      model: model,
                                      function: context.read<HomeBloc>().calc))
                                ],
                              ),
                            ))
                  ],
                ),
              )))
        ])));
  }
}
