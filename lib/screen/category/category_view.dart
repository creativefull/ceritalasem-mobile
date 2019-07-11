import 'package:flutter/material.dart';
import './category_model.dart';
import '../cerita/cerita_by_kategori_view.dart';
import '../../config/api.dart' show urlAssets;

class CategoryView extends CategoryModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Kategori'),
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
          ) : SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0
                  ),
                  itemBuilder: (_, int index) {
                    return Hero(
                      tag: 'cerita${kategoriModel[index].id}',
                      child: Material(
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CeritaByKategori(kategori: kategoriModel[index])
                          )),
                          child: GridTile(
                            header: kategoriModel[index].imageIcon == null ? SizedBox(child: Container(
                              color: Colors.black.withOpacity(.2),
                            ), width: double.infinity, height: 200.0) : SizedBox(
                              width: double.infinity, height: 200.0, child : Image.network(urlAssets + '/' + kategoriModel[index].imageIcon, fit: BoxFit.cover)),
                            child: Container(),
                            footer: Container(
                              color: Colors.white.withOpacity(.8),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(kategoriModel[index].namaKategori, style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontFamily: 'Raleway Bold'
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: kategoriModel.length,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}