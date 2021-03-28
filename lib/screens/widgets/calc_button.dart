import 'package:calc/models/calc_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final CalcModel model;
  final Function function;

  CalcButton({@required this.model, @required this.function});

  Widget _build(BuildContext context) {
    return Expanded(
        child: Container(
          margin: EdgeInsets.all(6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () => function(model: model),
            child: Center(
                child: FittedBox(
                  child: Text(model.value, style: Theme.of(context).primaryTextTheme.headline5),
                )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
