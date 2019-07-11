import 'package:flutter/material.dart';
import '../components/gradientButton.dart';
import './process/register.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends RegisterModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Daftar Member Baru', style: TextStyle(
          color: Theme.of(context).primaryColor
        ), textAlign: TextAlign.center),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/icon-register.png', fit: BoxFit.contain),
                SizedBox(height: 10.0),
                Text('Buat Akun Baru', style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600
                )),
                SizedBox(height: 10.0),
                Text('Daftar menjadi user untuk dapatkan akses lebih banyak ke aplikasi ini', style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300
                ), softWrap: true, textAlign: TextAlign.center),
                SizedBox(height: 40.0),
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 10.0)
                    ]
                  ),
                  child: Form(
                    key: formRegister,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: namaController,
                          decoration: InputDecoration(
                            hintText: 'Nama Lengkap',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.supervised_user_circle, color: Theme.of(context).primaryColor)
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Kamu pasti punya nama kan ? ayo disini dong';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).primaryColor)
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email tidak boleh kosong ya';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.keyboard, color: Theme.of(context).primaryColor)
                          ),
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              if (value.length <= 8) {
                                return 'Password kamu masih kurang dari 8 karakter loh';
                              } else {
                                return 'Password Kamu tidak boleh kosong';
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Konfirmasi Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.keyboard, color: Theme.of(context).primaryColor)
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              if (value.length <= 8) {
                                return 'Password kamu masih kurang dari 8 karakter loh';
                              } else if (value != passwordController.text) {
                                return 'Konfirmasi password kamu masih salah, ayo di ingat-ingat';
                              } else {
                                return 'Password Kamu tidak boleh kosong';
                              }
                            }
                          },
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Alamat Lengkap',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.pin_drop, color: Theme.of(context).primaryColor)
                          ),
                          keyboardType: TextInputType.text,
                          controller: alamatController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              if (value.length < 5) {
                                return 'Alamat kamu kok pendek banget, yakin sudah lengkap ?';
                              } else {
                                return 'Kamu pasti punya alamat dong, ayo disini';
                              }
                            }
                          },
                        ),
                        SizedBox(height: 40.0),
                        GradientButton(
                          text: 'Lanjutkan',
                          onTap: onSubmitRegister,
                          width: double.infinity,
                          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
                        )
                      ],
                    ),
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