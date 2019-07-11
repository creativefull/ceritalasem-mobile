import 'package:flutter/material.dart';
import './lokasi_model.dart';
import './lokasi.dart';
import '../../models/lokasi.dart' as LokasiData;
import '../../models/kecamatan.dart';
import '../cerita/cerita.dart';

class LokasiPageView extends LokasiModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Lokasi'),
            expandedHeight: 200.0,
            backgroundColor: Theme.of(context).primaryColor,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Pilih Kecamatan'),
            ),
          ),
          SliverFillRemaining(
            child: loading ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ) : ListView.builder(
              itemCount: listKecamatan.length,
              controller: scrollController,
              physics: PageScrollPhysics(),
              itemBuilder: (_, int index) {
                KecamatanModel kecamatan = listKecamatan[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (_) => LokasiSubPage(kecamatan.id)
                    ));
                  },
                  leading: Hero(
                    tag: 'kecamatan'+kecamatan.id.toString(),
                    child: Icon(Icons.location_city, color: Theme.of(context).primaryColor)
                  ),
                  title: Text(kecamatan?.namaKecamatan)
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class LokasiPageSubView extends SubLokasiModel {  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Lokasi'),
            expandedHeight: 200.0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              centerTitle: true,
              title: Hero(
                tag: 'kecamatan' + widget.id.toString(),
                child: Icon(Icons.location_city, color: Colors.white, size: 64.0)
              ),
            ),
          ),
          SliverFillRemaining(
            child: loading ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            ) : ListView.builder(
              itemCount: listLokasi.length,
              physics: ScrollPhysics(),
              itemBuilder: (_, int index) {
                LokasiData.LokasiModel lokasi = listLokasi[index];

                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CeritaByLokasi(lokasi: listLokasi[index])
                    ));
                  },
                  leading: Icon(Icons.pin_drop, color: Theme.of(context).primaryColor),
                  title: Text(lokasi?.namaLokasi.toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}