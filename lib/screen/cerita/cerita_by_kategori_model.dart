import 'package:flutter/material.dart';
import './cerita_by_kategori_view.dart';
import '../../models/cerita.dart';
import './cerita_model.dart';

abstract class CeritaByLokasiModel extends State<CeritaByKategori> {
  bool loading = false;
  List<CeritaModel> listCerita = [];
  ScrollController scrollController = new ScrollController();
  int paging = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = new ScrollController()..addListener(scrollListener);
    getCerita();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void scrollListener() async {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      setListCerita(paging);
    }
  }

  void setListCerita(int page) async {
    List<CeritaModel> cm = await CeritaProses().getCerita('ceritaByKategori', widget.kategori.id.toString(), paging);
    if (cm.length > 0) {
      setState(() {
        paging += 1;
      });
      listCerita.addAll(cm);
    }
  }

  void getCerita() async {
    setState(() {
      loading = true;
    });

    List<CeritaModel> cm = await CeritaProses().getCerita('ceritaByKategori', widget.kategori.id.toString(), paging);
    if (cm != null) {
      listCerita.addAll(cm);
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }
}