import 'dart:convert';

import 'package:flutter/material.dart';
import './category.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;
import '../../models/kategori.dart';

abstract class CategoryModel extends State<Category> {
  bool loading = false;
  List<KategoriModel> kategoriModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKategori();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getKategori() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/kategori');
    if (response.statusCode == 200) {
      List<KategoriModel> listKategori = (jsonDecode(response.body)['data'] as List).map((f) {
        return new KategoriModel(
          id: f['id'],
          namaKategori: f['nama_kategori'],
          imageIcon: f['image_icon']
        );
      }).toList();

      setState(() {
        loading = false;
        kategoriModel = listKategori;
      });
    } else {
      setState(() {
        loading = false;
      });
    }  
  }
}