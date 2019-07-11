import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../models/kategori.dart';
import './cerita_by_kategori_model.dart';
import '../../config/api.dart' show urlAssets;
import '../home/home_view.dart';

class CeritaByKategori extends StatefulWidget {
  final KategoriModel kategori;

  CeritaByKategori({
    @required this.kategori
  });

  @override
  _CeritaByKategoriState createState() => _CeritaByKategoriState();
}

class _CeritaByKategoriState extends CeritaByLokasiModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.kategori.namaKategori.toUpperCase(), style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway Bold'
              )),
              centerTitle: true,
              background: Hero(
                tag: 'cerita' + widget.kategori.id.toString(),
                child: loading ? Container(
                  color: Colors.black.withOpacity(.5),
                ) : widget.kategori.imageIcon != null ? Image.network(urlAssets + '/' + widget.kategori.imageIcon, fit: BoxFit.cover) : Container(
                  color: Colors.black.withOpacity(.5),
                )
              )
            ),
          ),
          loading ? SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ) : listCerita.length == 0 ? SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text('Maaf, cerita masih kosong. mohon tunggu sampai ada yang upload cerita di sini ya', style: TextStyle(
                  fontSize: 20.0
                ), softWrap: true, textAlign: TextAlign.center,),
              ),
            ),
          ) : SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20.0),
                child: StaggeredGridView.countBuilder(
                  physics: PageScrollPhysics(),
                  controller: scrollController,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: listCerita.length,
                  itemBuilder: (_, int index) => ItemView(listCerita[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}