import 'dart:convert';

import 'package:flutter/material.dart';
import '../register.dart';
import '../../config/api.dart' show urlApi;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './auth.dart';

abstract class RegisterModel extends State<RegisterPage> {
  GlobalKey<FormState> formRegister = new GlobalKey<FormState>();
  TextEditingController namaController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();

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

  void onSubmitRegister() async {
    if (formRegister.currentState.validate()) {
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

      Map<String, dynamic> dataToSend = {
        'nama' : namaController.text,
        'domisili' : alamatController.text,
        'email' : emailController.text,
        'password' : passwordController.text
      };

      http.Response response = await http.post(urlApi + '/register', body: dataToSend);
      if (response.statusCode == 200) {
        Map<dynamic, dynamic> data = jsonDecode(response.body);
        Navigator.of(context, rootNavigator: true).pop();
        if (!data['success']) {
          print('gagal');
          Alert(
            title: 'Warning',
            context: context,
            content: Icon(Icons.warning, size: 60.0, color: Colors.red),
            desc: data['msg'],
            buttons: [
              DialogButton(
                child: Text('Tutup', style: TextStyle(
                  color: Colors.white
                )),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ]
          ).show();
        } else {
          /*
          LOGIN
          */
          UserModel user = await Auth().sendLogin(emailController.text, passwordController.text);
          print(user);
          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }
      }
    }
  }
}