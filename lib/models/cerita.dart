import 'package:flutter/material.dart';

class CeritaModel {
  final int id;
  final String title;
  final String cover;
  final int idUser;
  final String createdAt;
  final String createdString;
  final String permalink;
  final int idLokasi;
  final int idKategori;
  final int approved;
  final int idKecamatan;
  final String video;
  final bool isRating;
  final String namaUser;
  final String namaKategori;
  final String namaLokasi;
  final String lat;
  final String long;
  final String ceritaSingkat;
  final String url;

  CeritaModel({
    @required this.id,
    this.title,
    this.cover,
    this.idUser,
    this.createdAt,
    this.permalink,
    this.idLokasi,
    this.idKategori,
    this.approved,
    this.idKecamatan,
    this.video,
    this.isRating,
    this.createdString,
    this.namaUser,
    this.namaKategori,
    this.namaLokasi,
    this.lat,
    this.long,
    this.ceritaSingkat,
    this.url
  });
}