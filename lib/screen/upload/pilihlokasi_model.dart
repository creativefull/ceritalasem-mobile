import 'dart:convert';

import 'package:flutter/material.dart';
import './upload.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;
import '../../models/kecamatan.dart';

abstract class PilihLokasiModel extends State<PilihLokasiPage> {
  List<KecamatanModel> listKecamatan = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKecamatan();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getKecamatan() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/kecamatan');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<KecamatanModel> d = (data as List).map<KecamatanModel>((f) {
        return KecamatanModel(
          id: f['id'],
          namaKecamatan: f['nama_kecamatan']
        );
      }).toList();

      setState(() {
        listKecamatan = d;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}