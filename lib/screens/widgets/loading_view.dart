import 'package:calc/shared/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool withTitle;

  const LoadingView({this.withTitle = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Theme.of(context).platform == TargetPlatform.android
              ? const CircularProgressIndicator()
              : const CupertinoActivityIndicator(),
          if (withTitle) const Text(loadingTitle),
        ],
      ),
    );
  }
}
