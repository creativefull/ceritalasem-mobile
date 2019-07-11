import 'dart:convert';

import 'package:flutter/material.dart';
import './detail_item.dart';
import 'package:http/http.dart' as http;
import '../../models/cerita.dart';
import '../../config/api.dart' show urlApi;
import '../process/auth.dart';
import 'package:video_player/video_player.dart';
import '../process/auth.dart';

abstract class DetailItemModel extends State<DetailItem> {
  CeritaModel ceritaModel;
  List<CeritaModel> listRelated = [];
  TextEditingController komentarController = new TextEditingController();
  VideoPlayerController videoController;
  Auth auth = new Auth();
  GlobalKey<FormState> formKomentar = new GlobalKey<FormState>();

  bool loading = false;
  bool related = false;
  double lat = 0;
  double long = 0;
  bool isAuth = false;
  bool showRating = false;
  double ratingInput = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCeritaDetail();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    komentarController?.dispose();
    if (videoController != null) {
      videoController..dispose();
    }
  }

  void getCeritaDetail() async {
    isAuth = await auth.isLogin();

    setState(() {
      loading = true;
    });

    Map<String, String> headers = {};
    UserModel user = await Auth().getAuth();
    if (user != null) {
      headers.addAll({
        'token' : user.token
      });
    }
    
    http.Response response = await http.get(urlApi + '/cerita/' + widget.id.toString(), headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var f = data['data'];
      CeritaModel dataCerita = CeritaModel(
        id: f['id'],
        title: f['judul'],
        cover: f['cover'],
        idUser: f['id_user'],
        createdAt: f['created_at'],
        permalink: f['permalink'],
        idLokasi: f['id_lokasi'],
        idKategori: f['id_kategori'],
        approved: f['approved'],
        idKecamatan: f['id_kecamatan'],
        namaLokasi: f['nama_lokasi'],
        namaKategori: f['nama_kategori'],
        namaUser: f['author'],
        createdString: f['created_at_string'],
        lat: f['latitude'],
        long: f['longitude'],
        ceritaSingkat: f['cerita_singkat'],
        url: f['url'],
        isRating: f['is_rating'],
        video: f['video'] == null ? null : urlApi + '/' + f['video']
      );

      setState(() {
        loading = false;
        ceritaModel = dataCerita;
        lat = double.parse(dataCerita.lat).toDouble();
        long = double.parse(dataCerita.long).toDouble();
      });

      // INIT VIDEO
      if (ceritaModel.video != null) {
        videoController = VideoPlayerController.network(ceritaModel.video)..initialize().then((_) {
          print('Video loaded');
          setState(() {});
        });
      }

      await Future.delayed(Duration(seconds: 1));
      setState(() {
        showRating = true;
      });
      // getCeritaTerkait();
    }
  }

  void getCeritaTerkait() async {
    Map<String, dynamic> headers = {};
    UserModel user = await Auth().getAuth();
    if (user != null) {
      headers.addAll({
        'token' : user.token
      });
    }
    
    http.Response response = await http.get(urlApi + '/cerita/' + widget.id.toString() + '/related', headers: headers);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      if (data.length > 0) {
        List<CeritaModel> d = data.map((f) {
          return CeritaModel(
            id: f['id'],
            title: f['judul'],
            cover: f['cover'],
            idUser: f['id_user'],
            createdAt: f['created_at'],
            permalink: f['permalink'],
            idLokasi: f['id_lokasi'],
            idKategori: f['id_kategori'],
            approved: f['approved'],
            idKecamatan: f['id_kecamatan']
          );
        });

        setState(() {
          related = true;
          listRelated = d;
        });
      }
    }
  }

  void onRatingChanged(double value) async {
    setState(() {
      ratingInput = value;
    });
  }

  void onSendRating() async {
    if (formKomentar.currentState.validate()) {
      if (ratingInput == 0) {
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Mohon berikan bintang dulu sebelum komentar dikirim'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
          barrierDismissible: false
        );
      }
      UserModel user = await auth.getAuth();

      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 20.0),
                Text('Loading....')
              ],
            ),
          ),
        ),
        barrierDismissible: false
      );

      Map<String, dynamic> dataToSend = {
        'rating' : ratingInput,
        'deskripsi' : komentarController.text,
        'id_user' : user.userId,
        'id_cerita' : ceritaModel.id
      };
      Map<String, String> headers = {
        'content-type' : 'application/json',
        'token' : user.token
      };

      http.Response response = await http.post(urlApi + '/cerita/rating', body: jsonEncode(dataToSend), headers: headers);
      if (response.statusCode == 200) {
        Navigator.of(context, rootNavigator: true).pop();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Success'),
            content: Text('Rating anda sudah berhasil dikirim'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
          barrierDismissible: false
        ).then((value) {
          komentarController.text = '';
          getCeritaDetail();
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }
}