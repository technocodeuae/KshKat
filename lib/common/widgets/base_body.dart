import 'package:flutter/material.dart';

class BaseBody extends StatefulWidget {
  final Widget portraitWidget;
  final Widget landscapeWidget;
  final bool isSafeAreaTop;

  const BaseBody(
      {required this.landscapeWidget,
      required this.portraitWidget,
      this.isSafeAreaTop = true});

  @override
  _BaseBodyState createState() => _BaseBodyState();
}

class _BaseBodyState extends State<BaseBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: widget.isSafeAreaTop, child: _body(context));
  }

  Widget _body(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return widget.portraitWidget;
    } else {
      return widget.landscapeWidget;
    }
  }
}
