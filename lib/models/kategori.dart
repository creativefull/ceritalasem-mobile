import 'package:flutter/material.dart';

class KategoriModel {
  final int id;
  final String namaKategori;
  final String imageIcon;
  final String deskripsi;

  KategoriModel({
    @required this.id,
    @required this.namaKategori,
    this.imageIcon,
    this.deskripsi
  });
}