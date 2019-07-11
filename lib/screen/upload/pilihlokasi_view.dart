import 'package:flutter/material.dart';
import './pilihlokasi_model.dart';
import '../../models/kecamatan.dart';
import './pilihsublokasi_view.dart';

class PilihLokasiView extends PilihLokasiModel {
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
            title: Text('Pilih Kecamatan', style: TextStyle(
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
                itemCount: listKecamatan.length,
                shrinkWrap: true,
                itemBuilder: (_, int index) {
                  KecamatanModel kecamatan = listKecamatan[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => PilihSubLokasi(kecamatan.id, kecamatan.namaKecamatan)
                      ));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(.2),
                        child: Icon(Icons.location_city, color: Colors.green),
                      ),
                      title: Text(kecamatan.namaKecamatan)
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