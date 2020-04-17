import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final double _borderRadius;
  final Function _function;

  MyButton(this._title, this._icon, this._borderRadius, this._function);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius)),
        icon: Icon(
          _icon,
          color: Colors.white,
        ),
        label: Text(_title, style: TextStyle(color: Colors.white)),
        color: Color(0xff262626),
        onPressed: _function);
  }
}
