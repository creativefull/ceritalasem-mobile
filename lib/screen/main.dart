import 'package:flutter/material.dart';
import './home/home.dart';
import './category/category.dart';
import './profile/index.dart';
import './upload/upload.dart';
import './pencarian.dart';
import '../splash.dart';
import '../screen/register.dart';
import '../screen/login.dart';
import './lokasi/lokasi.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cerita Rembang',
      theme: ThemeData(
        primaryColor: Color(0XFF16A085),
        fontFamily: 'Raleway'
      ),
      routes: {
        '/' : (_) => Home(),
        '/splash' : (_) => SplashScreen(),
        '/register' : (_) => RegisterPage(),
        '/login' : (_) => LoginApp(),
        '/category' : (_) => Category(),
        '/profile' : (_) => Profile(),
        '/upload' : (_) => PilihLokasiPage(),
        '/pencarian' : (_) => PencarianPage(),
        '/lokasi' : (_) => LokasiPage()
      },
      initialRoute: '/',
    );
  }
}