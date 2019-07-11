import 'package:flutter/material.dart';
import './components/gradientButton.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset('images/splash.png', fit: BoxFit.contain),
                SizedBox(height: 10.0),
                Text('Ayo Mulai Sekarang', style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600
                )),
                SizedBox(height: 10.0),
                Text('Ciptakan Kota Rembang menjadi Kota impian kamu dengan mengupload cerita - cerita yang ada di sekitar Rembang', style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w100
                ), softWrap: true, textAlign: TextAlign.center),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                GradientButton(
                  text: 'Buat Akun Sekarang',
                  width: double.infinity,
                  onTap: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/login'),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('Sudah Punya Akun', style: TextStyle(
                      color: Theme.of(context).primaryColor
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}