import 'package:flutter/material.dart';

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  ValueTile(this.value, {this.label, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          this.label!=null?
          Text(
            this.label,
            style: TextStyle(color: Theme.of(context).disabledColor),
          ):Container(),
          SizedBox(
            height: 5,
          ),
          this.iconData != null
              ? Icon(
                  iconData,
                  size: 20,
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          Text(
            this.value,
          ),
        ],
      ),
    );
  }
}
