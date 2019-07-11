import 'dart:convert';

import 'package:flutter/material.dart';
import './upload.dart';
import 'package:zefyr/zefyr.dart';

abstract class TextEditorModel extends State<TextEditorPage> {
  FocusNode zefyrNode;
  ZefyrController zefyrController;
  List<dynamic> isi = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.documentIsi != null) {
      setState(() {
        isi = widget.documentIsi;
      });
    }
    
    print('ISI DARI HALAMAN INI');
    print(widget.documentIsi);
    final document = isi.length <= 0 ? new NotusDocument() : new NotusDocument.fromJson(isi);
    zefyrController = new ZefyrController(document);
    zefyrNode = new FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    zefyrController.dispose();
    zefyrNode.dispose();
  }

  void onSave() {
    List<dynamic> isiEditor = zefyrController.document.toJson();
    String value = jsonEncode(isiEditor);
    // setState(() {
    //   isi = jsonEncode(isiEditor);
    // });
    Navigator.of(context).pop(value);
  }
}