import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './cerita_model.dart';
import '../../config/api.dart' show urlAssets;
import '../home/home_view.dart';

class CeritaByLokasiView extends CeritaByLokasiModel {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.lokasi.namaLokasi.toUpperCase(), style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway Bold'
              )),
              centerTitle: true,
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