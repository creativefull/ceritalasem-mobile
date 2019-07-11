import 'package:flutter/material.dart';
import './cerita_by_lokasi_view.dart';
import '../../models/lokasi.dart';

class CeritaByLokasi extends StatefulWidget {
  final LokasiModel lokasi;
  CeritaByLokasi({@required this.lokasi});
  
  CeritaByLokasiView createState() => CeritaByLokasiView();
}