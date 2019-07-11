import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import './upload.dart';
import 'package:zefyr/zefyr.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import '../../models/kategori.dart';
import '../../config/api.dart' show urlApi;
import '.../../../../models/lokasi.dart';
import '.../../../../models/kecamatan.dart';
import '../process/auth.dart';
import 'package:async/async.dart';


abstract class UploadPageModel extends State<UploadPage> {
  File _image;
  File _video;

  Future getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = image;
    });
    if (image != null) {
      return Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => DetailUploadPage(
          image: _image,
          lokasi: LokasiModel(
            id: widget.idLokasi,
            namaLokasi: widget.namaLokasi
          ),
          kecamatan: KecamatanModel(
            id: widget.idKecamatan,
            namaKecamatan: widget.namaKecamatan
          ))
      ));
    }
  }

  Future getVideo() async {
    File fideo = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      _video = fideo;
    });
    if (_video != null) {
      return Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => DetailUploadPage(
          image: _image,
          video: _video,
          lokasi: LokasiModel(
            id: widget.idLokasi,
            namaLokasi: widget.namaLokasi
          ),
          kecamatan: KecamatanModel(
            id: widget.idKecamatan,
            namaKecamatan: widget.namaKecamatan
          ))
      ));
    }
  }

  void getSource() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.camera, color: Colors.green),
                label: Text('Dari Kamera', style: TextStyle(
                  fontSize: 20.0
                )),
                onPressed: () => getImage(ImageSource.camera)
              ),
              FlatButton.icon(
                icon: Icon(Icons.wallpaper, color: Colors.green),
                label: Text('Ambil Dari Gallery Kamu', style: TextStyle(
                  fontSize: 20.0
                )),
                onPressed: () => getImage(ImageSource.gallery)
              )
            ],
          ),
        );
      }
    );
  }

}

abstract class DetailUploadModel extends State<DetailUploadPage> {
  String kategori;
  int kategoriId;
  String ceritaLengkap;
  String lokasi;
  String kecamatan;
  File video;
  File cover;
  ZefyrController zefyrController;
  String documentCeritaLengkap;
  List<KategoriModel> kategoriModel = [];
  TextEditingController judul = new TextEditingController();
  TextEditingController ceritaSingkat = new TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchKategori();
    /*
    SET COVER
    */
    setState(() {
      cover = widget.image;
      video = widget.video;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    setState(() {
      cover = null;
      video = null;
    });
    super.dispose();
  }

  void fetchKategori() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/kategori');
    if (response.statusCode == 200) {
      List<KategoriModel> listKategori = (jsonDecode(response.body)['data'] as List).map((f) {
        return new KategoriModel(
          id: f['id'],
          namaKategori: f['nama_kategori']
        );
      }).toList();

      setState(() {
        loading = false;
        kategoriModel = listKategori;
      });
    }
  }

  void getVideo() async {
    File _video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    setState(() {
      video = _video;
    });
  }

  void customCoverCerita() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cover = image;
      setState(() {

      });
    }
  }

  void getKategori() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          child: ListView.builder(
            itemCount: kategoriModel.length,
            itemBuilder: (_, int index) {
              KategoriModel k = kategoriModel[index];
              return ListTile(
                title: Text(k.namaKategori),
                onTap: () {
                  setState(() {
                    kategori = k.namaKategori;
                    kategoriId = k.id;
                  });
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.data_usage, color: Colors.green),
              );
            },
          )
        );
      }
    );
  }

  void openTextEditor() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => TextEditorPage(documentCeritaLengkap == null ? [] : jsonDecode(documentCeritaLengkap) as List)
    )).then((isi) {
      print(isi);
      setState(() {
        documentCeritaLengkap = isi;
      });
    });
  }

  void hapusVideo() async {
    setState(() {
      video = null;
    });
  }

  void kirimData() async {
    if (documentCeritaLengkap == null || judul.text.isEmpty || ceritaSingkat.text.isEmpty) {
      return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Center(child: Icon(Icons.error, color: Colors.red, size: 100)),
              SizedBox(height: 20.0),
              Center(child: Text('Opps, Cerita Kamu Masih Belum Lengkap, Ayo Di Lengkapi', style: TextStyle(
                fontSize: 20.0
              ), textAlign: TextAlign.center)),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Ok, Lengkapi Lagi'),
                ),
              )
            ],
          )
        )
      );
    }
    
    setState(() {
      loading = true;
    });

    /*
    GET USER INFO
    */
    UserModel auth = await Auth().getAuth();
    var coverByte = new http.ByteStream(DelegatingStream.typed(cover.openRead()));

    /*
    KIRIM API
    */
    var uri = Uri.parse(urlApi + '/cerita');
    var rng = new Random();

    print(documentCeritaLengkap);
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll({
      'token' : auth.token
    });
    request.fields['judul'] = judul.text;
    request.fields['id_user'] = auth.userId.toString();
    request.fields['cerita'] = "{\"ops\" : ${documentCeritaLengkap} }";
    request.fields['id_lokasi'] = widget.lokasi.id.toString();
    request.fields['id_kategori'] = '0';
    request.fields['cerita_singkat'] = ceritaSingkat.text;

    if (cover != null) {
      request.files.add(
        new http.MultipartFile('cover', coverByte, cover.lengthSync(), filename: 'cover${rng.nextInt(1000000)}.jpg')
      );
    }
    
    if (video != null) {
      print('=========> TERNYATA ADA VIDEO');
      var videoByte = new http.ByteStream(DelegatingStream.typed(video.openRead()));
      request.files.add(
        new http.MultipartFile('video', videoByte, video.lengthSync(), filename: 'video${rng.nextInt(1000000)}.mp4')
      );
    }

    http.StreamedResponse response = await request.send();
    http.Response r = await http.Response.fromStream(response);
    print(r.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });

      Alert(
        context: context,
        title: 'Success',
        content: Icon(Icons.check, size: 64.0, color: Colors.green),
        desc: 'Cerita Kamu berhasil di kirim, akan di validasi oleh admin dulu ya',
        buttons: [
          DialogButton(
            child: Text('OK', style: TextStyle(
              color: Colors.white
            )),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },
          )
        ]
      ).show();
    } else {
      Alert(
        context: context,
        title: 'Warning',
        content: Icon(Icons.warning, size: 64.0, color: Colors.red),
        desc: 'Gagal Upload Cerita, Silahkan cek lagi form kamu',
        buttons: [
          DialogButton(
            child: Text('OK', style: TextStyle(
              color: Colors.white
            )),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          )
        ]
      ).show();
      setState(() {
        loading = false;
      });
    }
  }
}