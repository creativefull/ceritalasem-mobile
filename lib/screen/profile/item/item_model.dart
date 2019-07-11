import 'dart:convert';

import 'package:flutter/material.dart';
import './item.dart';
import 'package:http/http.dart' as http;
import '../../process/auth.dart';
import '../../../config/api.dart' show urlApi;
import '../../../models/cerita.dart';

abstract class MyItemModel extends State<MyItem> {
  List<CeritaModel> listCerita = [];
  int page = 0;
  Auth auth = new Auth();
  ScrollController scrollController = new ScrollController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setListCerita(page);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<List<CeritaModel>> getCerita() async {
    setState(() {
      loading = true;
    });

    UserModel user = await auth.getAuth();
    Map<String, String> headers = {
      'token' : user.token
    };

    http.Response response = await http.get(urlApi + '/user/cerita', headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success']) {
        List<CeritaModel> dataCerita = (data['data']['data'] as List).map((f) {
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

        setState(() {
          loading = false;
        });

        return dataCerita;
      } else {
        setState(() {
          loading = false;
        });
        return null;
      }
    } else {
      setState(() {
        loading = false;
      });

      return [];
    }
  }

  void setListCerita(int paging) async {
    List<CeritaModel> dataCerita = await getCerita();
    if (dataCerita.length > 0) {
      setState(() {
        paging += 1;
      });
      listCerita.addAll(dataCerita);
    }
  }
  
  void scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      setListCerita(page);
    }
  }
}