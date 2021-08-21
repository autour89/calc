import 'package:calc/models/calc_model.dart';
import 'package:calc/shared/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CalcButton extends StatelessWidget {
  final CalcModel model;
  final Function function;

  const CalcButton({required this.model, required this.function, Key? key})
      : super(key: key);

  Widget _build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Theme.of(context).secondaryHeaderColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25))),
          onPressed: () => function(model: model),
          child: Center(child: imageOrDefault(context)),
        ),
      ),
    );
  }

  Widget imageOrDefault(BuildContext context) {
    var image = SvgPicture.asset(backspaceImage);

    return model.isImage
        ? image
        : FittedBox(
            child: Text(model.value,
                style: Theme.of(context).primaryTextTheme.headline5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
