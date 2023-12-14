import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeShowCaseWidget extends StatelessWidget {
  const HomeShowCaseWidget(
      {super.key,
      required this.globalKey,
      required this.textInContainer,
      required this.child});

  final GlobalKey globalKey;
  final String textInContainer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Showcase(key: globalKey, description: textInContainer, child: child);
  }
}
