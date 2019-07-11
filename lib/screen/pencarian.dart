import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './process/pencarian.dart';
import './home/home_view.dart';

class PencarianPage extends StatefulWidget {
  @override
  _PencarianPageState createState() => _PencarianPageState();
}

class _PencarianPageState extends PencarianModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Pencarian'),
              centerTitle: true,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                        fontSize: 25.0
                      ),
                      controller: q,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 25.0
                        ),
                        labelStyle: TextStyle(
                          fontSize: 25.0
                        ),
                        hintText: 'Ketik saja disini apa yang kamu cari....'
                      ),
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (String value) {
                        submitPencarian(value);
                      },
                    ),
                    SizedBox(height: 40.0),
                    Text('Hasil Pencarian'),
                    Divider()
                  ],
                ),
              ) ,
              loading ? LoadingPencarian() : listCerita.length > 0 ? Container(
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
              ) : Container(
                child: Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Hero(
                          tag: 'icon-animate',
                          child: Material(
                            child: Icon(
                              Icons.youtube_searched_for, size: 100.0
                            ),
                          )
                        ),
                        Text('Pencarian Tidak di temukan', style: TextStyle(
                          fontSize: 25.0
                        ))
                      ],
                    ),
                  ),
                )
              )
            ]),
          )
        ],
      )
    );
  }
}

class LoadingPencarian extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 20.0),
          Text('Sedang Mencari Data...')
        ],
      ),
    );
  }
}