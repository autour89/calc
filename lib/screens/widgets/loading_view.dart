import 'package:calc/shared/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool withTitle;

  LoadingView({this.withTitle = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Theme.of(context).platform == TargetPlatform.android
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
          if (withTitle) Text(loadingTitle),
        ],
      ),
    );
  }
}
