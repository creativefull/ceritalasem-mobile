import 'package:flutter/material.dart';
import './detail_item_model.dart';
import '../../components/gradientButton.dart';
import './rating_view.dart';
import '../../config/api.dart' show urlApi;
import 'package:map_native/map_native.dart';
import 'package:video_player/video_player.dart';
import './baca_item.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 
import 'package:url_launcher/url_launcher.dart';

class DetailItemView extends DetailItemModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            title: loading ? Text('Loading ...') : ceritaModel != null ? Text(ceritaModel.title) : Text('Loading...'),
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Hero(
                tag: 'cerita' + widget.id.toString(),
                child: loading ? Container(
                  color: Colors.black.withOpacity(.5),
                ) : ceritaModel.cover != null ? Image.network(urlApi + '/' + ceritaModel.cover, fit: BoxFit.cover) : Container(
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
          ) : SliverList(delegate: SliverChildListDelegate([
            Container(
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(.3), blurRadius: 5.0)]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(ceritaModel.title, style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20.0
                    )),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Text(ceritaModel.namaLokasi??'Tidak ada Lokasi', style: TextStyle(
                          fontSize: 10.0
                        )),
                        SizedBox(width: 5.0),
                        Text('-', style: TextStyle(
                          fontSize: 10.0
                        )),
                        SizedBox(width: 5.0),
                        Text(ceritaModel.namaUser, style: TextStyle(
                          fontSize: 10.0
                        )),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(.2),
                          foregroundColor: Theme.of(context).primaryColor,
                          child: Text(ceritaModel.namaUser.substring(0,1).toUpperCase(), style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold
                          )),
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(ceritaModel.namaUser.toUpperCase(), style: TextStyle(
                              fontSize: 15.0,
                              color: Theme.of(context).primaryColor
                            )),
                            Text(ceritaModel.createdString, style: TextStyle(
                              fontSize: 10.0
                            ))
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text('Cerita Singkat', style: TextStyle(
                      color: Theme.of(context).primaryColor
                    )),
                    SizedBox(height: 10.0),
                    Text(ceritaModel.ceritaSingkat??'Tidak ada keterangan cerita singkat')
                  ],
                ),
              ),
            ceritaModel.video != null ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Video'),
            ) : Container(),
            ceritaModel.video != null ? Container(
              padding: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  videoController.value.isPlaying ? videoController.pause() : videoController.play();
                },
                child: videoController.value.initialized ? Container(
                  width: 200.0,
                  height: 400.0,
                  child: AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
                    child: VideoPlayer(videoController),
                )) : Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ) : Container(),
            // MAP VIEW
            Container(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: 200.0,
                height: 200.0,
                child: MapView(
                  initialLocation: LatLong(long, lat),
                  inititialZoom: 15.0,
                ),
              )
            ),
            Container(
              child: FlatButton.icon(
                icon: Icon(Icons.navigation, color: Colors.green),
                label: Text('Kunjungi Lokasi'),
                onPressed: () async {
                  String url = 'https://www.google.com/maps/search/?api=1&query=${ceritaModel.long},${ceritaModel.lat}';
                  bool canOpen = await canLaunch(url);
                  if (canOpen) {
                    await launch(url);
                  } else {
                    print('tidak dapat di luncurkan');
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Warning'),
                        content: Text('Aplikasi Google map kamu belum di install, silahkan install dulu ya'),
                      )
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 40.0),
            // Komentar
            isAuth ? !ceritaModel.isRating ? Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: onRatingChanged,
                  starCount: 5,
                  rating: ratingInput,
                  size: 40.0,
                  color: Colors.yellow.shade900,
                ),
              ),
            ) : Container() : Container(),
            isAuth ? !ceritaModel.isRating ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Berikan Rating Cerita'),
            ) : Container() : Container(),
            isAuth ? !ceritaModel.isRating ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Form(
                      key: formKomentar,
                      child: TextFormField(
                        focusNode: FocusNode(),
                        controller: komentarController,
                        decoration: InputDecoration(
                          hintText: 'Beri Komentar kamu'
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Harap masukkan komentar kamu ya';
                          }
                          return null;
                        },
                        onFieldSubmitted: (String value) {
                          onSendRating();
                        },
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.send, color: Colors.green),
                    label: Text('Kirim', style: TextStyle(
                      color: Theme.of(context).primaryColor
                    )),
                    onPressed: onSendRating,
                  )
                ],
              ),
            ) : Container() : Container(),
            showRating ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RatingListView(ceritaModel.id)
            ) : Container(),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: MainAxisSize.min,
            //     children: <Widget>[
            //       SizedBox(height: 20.0),
            //       Text('Cerita Yang Sama'),
            //       Flexible(
            //         child: StaggeredGridView.countBuilder(
            //           physics: PageScrollPhysics(),
            //           crossAxisCount: 4,
            //           shrinkWrap: true,
            //           itemCount: 1,
            //           itemBuilder: (_, int index) => ItemView(ceritaModel),
            //           staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 3 : 2),
            //           mainAxisSpacing: 4.0,
            //           crossAxisSpacing: 4.0,
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ]))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 60.0,
          child: GradientButton(
            colors: [Color(0XFF16A085), Color(0XFF47EBE0)],
            text: 'Baca Cerita Lengkapnya Yuk !',
            onTap: ceritaModel != null ? () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BacaItemView(title: ceritaModel?.title, url: ceritaModel?.url)
              ));
            } : null,
          ),
        ),
      )
    );
  }
}