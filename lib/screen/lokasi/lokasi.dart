import 'package:flutter/material.dart';
import './lokasi_view.dart';

class LokasiPage extends StatefulWidget {
  LokasiPageView createState() => new LokasiPageView();
}

class LokasiSubPage extends StatefulWidget {
  final int id;
  LokasiSubPage(this.id);

  LokasiPageSubView createState() => new LokasiPageSubView();
}