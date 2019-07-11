import 'package:flutter/material.dart';
import './home_model.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../detail_item/detail_item.dart';
import '../../models/cerita.dart';
import '../process/auth.dart';
import '../../config/api.dart' show urlApi;
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text('Cerita Rakyat Rembang'),
        backgroundColorStart: Color(0XFF16A085),
        backgroundColorEnd: Color(0XFF47EBE0),
        actions: <Widget>[
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/pencarian');
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Icon(Icons.search),
          //   ),
          // ),
          isLogin ? InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Info'),
                  content: Text('Apakah anda yakin ingin logout ? '),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Auth().logout();
                        Navigator.of(context, rootNavigator: true).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                      },
                      child: Text('Ok, Logout saja'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                      child: Text('Tidak jadi'),
                    ),
                  ],
                )
              );              
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.exit_to_app),
            ),
          ):Container(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: loading ? Center(
          child: CircularProgressIndicator()
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // SizedBox(
            //   width: double.infinity,
            //   height: 40.0,
            //   child: MenuCategory()
            // ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refreshCerita,
                child: StaggeredGridView.countBuilder(
                  physics: ScrollPhysics(),
                  controller: scrollController,
                  crossAxisCount: 4,
                  itemCount: dataCerita.length,
                  itemBuilder: (_, int index) => ItemView(dataCerita[index]),
                  staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              )
            )
          ],
        ),
      ),
      floatingActionButton: !isLogin ? FloatingActionButton.extended(
        icon: Icon(Icons.supervised_user_circle),
        label: Text('Daftar / Login'),
        onPressed: () {
          Navigator.of(context).pushNamed('/splash');
        },
        backgroundColor: Theme.of(context).primaryColor,
      ) : Hero(
        tag: 'icon-animate',
        child: Material(
          color: Colors.transparent,
          child : FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.of(context).pushNamed('/upload');
            },
          )
        )
      ),
      floatingActionButtonLocation: isLogin ? FloatingActionButtonLocation.centerDocked : FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.apps, color: Theme.of(context).primaryColor),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/pencarian');
                },
                icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                tooltip: 'Pencarian',
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/lokasi');
                },
                icon: Icon(Icons.branding_watermark, color: Theme.of(context).primaryColorLight),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                icon: Icon(Icons.person_pin_circle, color: Theme.of(context).primaryColorLight),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final CeritaModel ceritaModel;

  ItemView(this.ceritaModel);
  
  @override
  Widget build(BuildContext context) {
    var imageCover = ceritaModel.cover != null ? urlApi + '/' + ceritaModel.cover : 'https://cdn.dribbble.com/users/1803663/screenshots/6408871/evening_kerala_2x.png';

    return Hero(
      tag: 'cerita' + ceritaModel.id.toString(),
      transitionOnUserGestures: true,
      child: Material(
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetailItem(ceritaModel.id)
          )),
          child: Card(
            borderOnForeground: false,
            color: Colors.transparent,
            elevation: 0.0,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.black.withOpacity(.2),
                    image: DecorationImage(
                      image: NetworkImage(imageCover),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        child: Text(ceritaModel.title != null ? ceritaModel.title.toUpperCase() : 'Tidak ada judul', style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Raleway Bold',
                          color: Colors.white
                        ), softWrap: true),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: PageScrollPhysics(),
      itemBuilder: (_, int index) {
        return Container(
          margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: index.isEven ? [Color(0XFF16A085), Color(0XFF47EBE0)] : [Color(0XFF8E44AD), Color(0XFFBE90D4)]
            ),
            borderRadius: BorderRadius.circular(100.0)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.local_activity, color: Colors.white),
              SizedBox(width: 10.0),
              Text('Rembang', style: TextStyle(
                color: Colors.white
              ))
            ],
          ),
        );
      },
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );
  }
}