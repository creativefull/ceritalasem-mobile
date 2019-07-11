import 'package:flutter/material.dart';

class RatingModel {
  final int id;
  final int rating;
  final String deskripsi;
  final String namaUser;
  final int idCerita;

  RatingModel({
    @required this.id,
    this.rating,
    this.deskripsi,
    this.namaUser,
    this.idCerita
  });
}