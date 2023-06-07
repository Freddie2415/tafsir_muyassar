import 'package:flutter/material.dart';

class LayoutBody extends StatelessWidget {
  final Widget child;
  const LayoutBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: child,
    ));
  }
}
