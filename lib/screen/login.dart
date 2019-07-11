import 'package:ceritalasem/components/gradientButton.dart';
import 'package:flutter/material.dart';
import './process/login.dart';

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends LoginModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: Text('Masuk ke Aplikasi'),
              centerTitle: true,
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: formLogin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email Kamu',
                        prefixIcon: Icon(Icons.alternate_email)
                      ),
                      controller: emailController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Email tidak boleh kosong ya';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password Kamu',
                        prefixIcon: Icon(Icons.vpn_key)
                      ),
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
                    SizedBox(height: 40.0),
                    Center(
                      child: GradientButton(
                        text: 'Lanjutkan',
                        onTap: onSubmitLogin,
                        width: double.infinity,
                        colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
                      )
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}