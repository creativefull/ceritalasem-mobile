import 'dart:convert';

import 'package:flutter/material.dart';
import './lokasi.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;
import '../../models/lokasi.dart' as LokasiData;
import '../../models/kecamatan.dart';

abstract class LokasiModel extends State<LokasiPage> {
  List<KecamatanModel> listKecamatan = [];
  bool loading = false;
  int nextKecamatan = 0;
  ScrollController scrollController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKecamatan();
    scrollController = new ScrollController()..addListener(listenerScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void listenerScroll() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      // getKecamatan();
    }
  }

  void getKecamatan() async {
    if (nextKecamatan == 0) {
      setState(() {
        loading = true;
      });
    }
    
    http.Response response = await http.get(urlApi + '/kecamatan?page=' + nextKecamatan.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      if (data['success']) {
        List<KecamatanModel> dataKecamatan = (data['data'] as List).map((f) {
          return new KecamatanModel(
            id: f['id'],
            namaKecamatan: f['nama_kecamatan']
          );
        }).toList();

        if (dataKecamatan.length > 0) {
          listKecamatan.addAll(dataKecamatan);
          setState(() {
            nextKecamatan += 1;
          });
        }
        setState(() {
          loading = false;
        });
      }
    }
  }
}

abstract class SubLokasiModel extends State<LokasiSubPage> {
  bool loading = false;
  int nextLokasi = 0;
  List<LokasiData.LokasiModel> listLokasi = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLokasi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getLokasi() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/kecamatan/' + widget.id.toString() + '/lokasi?page=' + nextLokasi.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success']) {
        List<LokasiData.LokasiModel> dataLokasi = (data['data'] as List).map((f) {
          return new LokasiData.LokasiModel(
            id: f['id'],
            namaLokasi: f['nama_lokasi']
          );
        }).toList();

        if (dataLokasi.length > 0) {
          listLokasi.addAll(dataLokasi);
          setState(() {
            nextLokasi += 1;
          });
        }

        setState(() {
          loading = false;
        });
      }
    }
  }
}