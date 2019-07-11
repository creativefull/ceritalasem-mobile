import 'dart:io';

import 'package:flutter/material.dart';
import './upload_view.dart';
import './pilihlokasi_view.dart';
import './detail_upload_view.dart';
import './texteditor_view.dart';
import '.../../../../models/lokasi.dart';
import '.../../../../models/kecamatan.dart';

class UploadPage extends StatefulWidget {
  UploadPage(this.idKecamatan, this.idLokasi, {
    this.namaKecamatan,
    this.namaLokasi
  });
  final int idKecamatan;
  final int idLokasi;
  final String namaKecamatan;
  final String namaLokasi;
  UploadPageView createState() => UploadPageView();
}

class PilihLokasiPage extends StatefulWidget {
  PilihLokasiView createState() => PilihLokasiView();
}

class DetailUploadPage extends StatefulWidget {
  final LokasiModel lokasi;
  final KecamatanModel kecamatan;

  final File image;
  final File video;
  DetailUploadPage({
    @required this.image,
    @required this.lokasi,
    @required this.kecamatan,
    this.video
  });

  DetailUploadView createState() => DetailUploadView();
}

class TextEditorPage extends StatefulWidget {
  final List<dynamic> documentIsi;
  TextEditorPage(this.documentIsi);

  TextEditorView createState() => TextEditorView();
}