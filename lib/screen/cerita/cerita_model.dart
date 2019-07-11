import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cerita.dart';
import '../../models/cerita.dart';
import '../../config/api.dart' show urlApi;

abstract class CeritaByLokasiModel extends State<CeritaByLokasi> {
  List<CeritaModel> listCerita = [];
  bool loading = false;
  int nextList = 0;
  ScrollController scrollController = new ScrollController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = new ScrollController()..addListener(scrollListener);
    getCerita();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  void scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      setListCerita(nextList);
    }
  }

  void setListCerita(int page) async {
    List<CeritaModel> cm = await CeritaProses().getCerita('ceritaByLokasi', widget.lokasi.id.toString(), nextList);
    if (cm.length > 0) {
      setState(() {
        nextList += 1;
      });
      listCerita.addAll(cm);
    }
  }

  void getCerita() async {
    setState(() {
      loading = true;
    });

    List<CeritaModel> cm = await CeritaProses().getCerita('ceritaByLokasi', widget.lokasi.id.toString(), nextList);
    if (cm != null) {
      listCerita.addAll(cm);
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

class CeritaProses {
  Map<String, Map<String, String>> listAPI = {
    'ceritaByLokasi' : {
      'where' : 'id_lokasi'
    },
    'ceritaByKategori' : {
      'where' : 'id_kategori'
    },
  };

  Future<List<CeritaModel>> getCerita(String filter, String value, int page) async {
    Map<String, dynamic> api = listAPI[filter];
    if (api != null) {
      String urle = urlApi + '/' + filter + '?' + api['where'] + '=' + value + '&page=' + page.toString();
      http.Response response = await http.get(urle);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['success']) {
          List<CeritaModel> listCM = (data['data']['data'] as List).map((f) {
            return new CeritaModel(
              id : f['id'],
              title: f['judul'],
              cover: f['cover'],
              idUser: f['id_user']
            );
          }).toList();
          return listCM;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}