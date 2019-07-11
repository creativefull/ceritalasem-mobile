import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ceritalasem/config/api.dart' show urlApi;
import 'package:flutter/material.dart';
import '../pencarian.dart';
import '../../models/cerita.dart';

abstract class PencarianModel extends State<PencarianPage> {
  bool loading = false;
  List<CeritaModel> listCerita = [];
  ScrollController scrollController = new ScrollController();
  int page = 0;
  TextEditingController q = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = new ScrollController()..addListener(scrollListener);
  }

  Future<List<CeritaModel>> getCerita() async {
    http.Response response = await http.get(urlApi + '/cerita/cari?q=' + q.text + '&page=' + page.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
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

      return dataCerita;
    } else {
      return null;
    }
  }

  void setListCerita(int paging) async {
    List<CeritaModel> dataCerita = await getCerita();
    if (dataCerita.length > 0) {
      setState(() {
        page += 1;
      });
      listCerita.addAll(dataCerita);
    }
  }
  
  void scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      setListCerita(page);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  
  void submitPencarian(String query) async {
    setState(() {
      loading = true;
      page = 0;
      listCerita = [];
    });
    List<CeritaModel> dataCerita = await getCerita();
    listCerita.addAll(dataCerita);
    setState(() {
      loading = false;
    });
  }
}

class PencarianData {
  final String title;
  final String image;
  final String id;

  PencarianData({
    @required this.id,
    @required this.title,
    @required this.image
  });
}