import 'package:flutter/material.dart';
import './screen/main.dart';

class PayuniApp extends StatefulWidget {
  @override
  _PayuniAppState createState() => _PayuniAppState();
}

class _PayuniAppState extends State<PayuniApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0XFF921DDB),
        primaryColorLight: Color(0XFFD5A8F5),
        fontFamily: 'Raleway'
      ),
      routes: {
        '/' : (_) => MainApp(),
      },
      initialRoute: '/',
    );
  }
}