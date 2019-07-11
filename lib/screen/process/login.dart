import 'package:flutter/material.dart';
import '../login.dart';
import './auth.dart';

abstract class LoginModel extends State<LoginApp> {
  final GlobalKey<FormState> formLogin = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onSubmitLogin() async {
    if (formLogin.currentState.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 10.0),
                  Text('Loading....')
                ],
              ),
            ),
          );
        }
      );

      UserModel user = await Auth().sendLogin(emailController.text, passwordController.text);
      Navigator.of(context, rootNavigator: true).pop();
      if (user == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: Text('Warning'),
              content: Text('Username / Password Tidak Benar'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ],
            );
          }
        );
      } else {
        print(user);
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    }    
  }
}