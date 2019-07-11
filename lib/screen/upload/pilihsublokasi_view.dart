import 'dart:convert';

import 'package:ceritalasem/screen/upload/upload.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;
import '../../models/lokasi.dart';

class PilihSubLokasi extends StatefulWidget {
  final int idKecamatan;
  final String namaKecamatan;
  PilihSubLokasi(this.idKecamatan, this.namaKecamatan);

  @override
  _PilihSubLokasiState createState() => _PilihSubLokasiState();
}

class _PilihSubLokasiState extends State<PilihSubLokasi> {
  List<LokasiModel> listLokasi = [];
  bool loading = false;

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

    http.Response response = await http.get(urlApi + '/kecamatan/' + widget.idKecamatan.toString() + '/lokasi');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<LokasiModel> d = (data as List).map<LokasiModel>((f) {
        return LokasiModel(
          id: f['id'],
          namaLokasi: f['nama_lokasi']
        );
      }).toList();

      setState(() {
        listLokasi = d;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 300.0,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text('Pilih Lokasi', style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20.0
            )),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: loading ? Center(child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              )) : ListView.builder(
                physics: PageScrollPhysics(),
                itemCount: listLokasi.length,
                shrinkWrap: true,
                itemBuilder: (_, int index) {
                  LokasiModel lokasi = listLokasi[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => UploadPage(widget.idKecamatan, lokasi.id, namaLokasi: lokasi.namaLokasi, namaKecamatan: widget.namaKecamatan)
                      ));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(.2),
                        child: Icon(Icons.location_city, color: Colors.green),
                      ),
                      title: Text(lokasi.namaLokasi)
                    ),
                  );
                },
              ),
            )
          ]),
        )
      ],
    )
  );
  }
}