import 'package:flutter/material.dart';
import './detail_item_view.dart';

class DetailItem extends StatefulWidget {
  final int id;
  DetailItem(this.id);
  
  DetailItemView createState() => DetailItemView();
}