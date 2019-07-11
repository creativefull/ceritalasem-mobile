import 'dart:convert';

import 'package:flutter/material.dart';
import './index.dart';
import '../process/auth.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;

abstract class ProfileModel extends State<Profile> {
  UserModel profile;
  Stat stat;
  bool isAuth = false;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getProfile() async {
    setState(() {
      loading = true;
    });

    isAuth = await Auth().isLogin();
    if (isAuth) {
      profile = await Auth().getAuth();
      getStat();
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });      
    }
  }

  void getStat() async {
    setState(() {
      loading = true;
    });

    Map<String, String> headers = {
      'token' : profile.token
    };

    http.Response response = await http.get(urlApi + '/stats', headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body)['data'];
      stat = new Stat(
        approve: data['approve'],
        disapprove: data['disapprove'],
        pending: data['pending']
      );
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}

class Stat {
  final int approve;
  final int disapprove;
  final int pending;

  Stat({
    this.approve,
    this.disapprove,
    this.pending
  });
}