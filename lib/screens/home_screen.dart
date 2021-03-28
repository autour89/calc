import 'package:calc/screens/widgets/calc_button.dart';
import 'package:calc/screens/widgets/loading_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../blocs/home_bloc.dart';
import '../screens/styles/extensions.dart';

class HomePage extends GetView<HomeBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: FutureBuilder(
            future: controller.appStart(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? LoadingView(withTitle: true)
                  : SafeArea(
                      child: Column(children: [
                      Expanded(flex: 3, child: getDisplay(context)),
                      Expanded(flex: 4, child: getKeyboard(context))
                    ]));
            }));
  }

  Widget getDisplay(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(10),
      child: Align(
          alignment: Alignment.centerRight,
          child: FittedBox(
              child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 30),
            child: Obx(() => Text(
                  controller.output,
                  style: Theme.of(context).primaryTextTheme.headline1,
                )),
          ))),
    );
  }

  Widget getKeyboard(BuildContext context) {
    return Center(
        child: ConstrainedBox(
      constraints: BoxConstraints(minHeight: 400, maxWidth: 350),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  ...controller.operands.map((iterable) => Expanded(
                        child: Row(
                          children: [
                            ...iterable.map((model) => CalcButton(
                                model: model, function: controller.calculate))
                          ],
                        ),
                      ))
                ],
              )),
          Expanded(
              child: Column(
            children: [
              ...controller.functions.map((model) =>
                  CalcButton(model: model, function: controller.calculate))
            ],
          ))
        ],
      ),
    ));
  }
}
