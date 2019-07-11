import 'dart:convert';

import 'package:flutter/material.dart';
import './home.dart';
import '../process/auth.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;
import '../../models/cerita.dart';

abstract class HomeViewModel extends State<Home> {
  ScrollController scrollController;

  Auth auth = new Auth();
  UserModel userInfo;
  bool loading = false;
  bool isLogin = false;
  int paggingCerita = 1;
  bool isError = false;
  bool simpleLoading = false;

  List<CeritaModel> dataCerita = [];

  @override
  void initState() {
    scrollController = new ScrollController()..addListener(scrollListener);

    super.initState();
    setState(() {
      loading = true;
    });

    getUser();
  }

  Future<void> refreshCerita() async {
    setState(() {
      paggingCerita = 1;
    });

    setListCerita(paggingCerita);
  }

  void getUser() async {
    UserModel user = await auth.getAuth();
    bool apakahLogin = await auth.isLogin();

    setState(() {
      userInfo = user;
      isLogin = apakahLogin;
    });

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      loading = false;
    });

    /* GET CERITA */
    setListCerita(paggingCerita);
  }

  Future<List<CeritaModel>> getCerita() async {
    http.Response response = await http.get(urlApi + '/cerita?page=' + paggingCerita.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<CeritaModel> listCerita = (data['data']['data'] as List).map((f) {
        return CeritaModel(
          id: f['id'],
          title: f['judul'],
          cover: f['cover'],
          idUser: f['id_user'],
          createdAt: f['created_at'],
          permalink: f['permalink'],
          idLokasi: f['id_lokasi'],
          idKategori: f['id_kategori'],
          approved: f['approved'],
          idKecamatan: f['id_kecamatan']
        );
      }).toList();

      return listCerita;
    } else {
      return null;
    }
  }

  void setListCerita(int paging) async {
    List<CeritaModel> listCerita = await getCerita();
    if (listCerita.length > 0) {
      setState(() {
        paggingCerita += 1;
      });
      dataCerita.addAll(listCerita);
    }
  }
  
  void scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      print('SUDAH MAX');
      setListCerita(paggingCerita);
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}