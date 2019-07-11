import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final double width;
  final Function onTap;

  GradientButton({
    @required this.text,
    @required this.colors,
    this.width,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors
          ),
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white
        ),
        child: Text(text?.toString(), textAlign: TextAlign.center, style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
          fontWeight: FontWeight.w300
        )),
      ),
    );
  }
}