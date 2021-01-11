import 'package:flutter/material.dart';

class VerticalDividerBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Center(
          child: Container(
            width: 1,
            height: 30,
            color: Theme.of(context).accentColor.withAlpha(50),
          )),
    );
  }
}
