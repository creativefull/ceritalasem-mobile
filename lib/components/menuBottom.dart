import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Image icon;
  final String label;

  MenuButton({
    @required this.icon,
    @required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: icon,
          ),
        ),
        SizedBox(height: 10.0),
        Text(label.toString(), style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500
        ), textAlign: TextAlign.center)
      ],
    );
  }
}