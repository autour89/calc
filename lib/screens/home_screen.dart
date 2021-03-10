import 'package:calc/screens/widgets/calc_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';
import '../blocs/home_bloc.dart';
import '../screens/styles/extensions.dart';

class HomePage extends GetView<HomeBloc> {
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
                        child: Obx(() => Text(
                              controller.output,
                              style:
                                  Theme.of(context).primaryTextTheme.headline1,
                            )),
                      )),
                  color: Colors.transparent)),
          Expanded(
              flex: 4,
              child: Center(
                  child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 400, maxWidth: 350),
                child: Column(
                  children: [
                    ...partition(controller.models, 3)
                        .map((iterable) => Expanded(
                              child: Row(
                                children: [
                                  ...iterable.map((model) => CalcButton(
                                      model: model, function: controller.calc))
                                ],
                              ),
                            ))
                  ],
                ),
              )))
        ])));
  }
}
