import 'package:flutter/material.dart';
import './texteditor_model.dart';
import 'package:zefyr/zefyr.dart';

class TextEditorView extends TextEditorModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tulis Cerita Lengkap'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: onSave,
            icon: Icon(Icons.save, color: Colors.white),
            label: Text('Simpan', style: TextStyle(
              color: Colors.white
            )),
          )
        ],
      ),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          controller: zefyrController,
          focusNode: zefyrNode,
        ),
      ),
    );
  }
}