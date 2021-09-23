import 'dart:math';

import 'package:flutter/material.dart';

class DialogBlock extends StatelessWidget {
  
  List<Widget>? _widgets;

  DialogBlock(List<Widget> widgets) {
    _widgets = widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.red, width: 1, ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              spreadRadius: 0,
              blurRadius: 32,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
      ),  
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ..._widgets!.map((widget) => widget == _widgets!.last ? Container(child: widget, margin: EdgeInsets.only(top: 20, bottom: 30)) : Container(child: widget, margin: EdgeInsets.only(top: 30))),
        ]
      ),
    );
  }
}