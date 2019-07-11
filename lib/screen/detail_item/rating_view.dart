import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;
import '../../models/rating.dart';

class RatingListView extends StatefulWidget {
  final int idCerita;
  RatingListView(this.idCerita);

  @override
  _RatingListViewState createState() => _RatingListViewState();
}

class _RatingListViewState extends State<RatingListView> {
  List<RatingModel> listRating = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListRating();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getListRating() async {
    setState(() {
      loading = true;
    });

    http.Response response = await http.get(urlApi + '/cerita/${widget.idCerita.toString()}/rating');
    if (response.statusCode == 200) {
      Map<String, dynamic> d = jsonDecode(response.body);
      if (d['success']) {
        List<RatingModel> lR = (d['data']['data'] as List).map<RatingModel>((f) {
          print(f);
          return new RatingModel(
            id: f['id'],
            rating: f['rating'],
            deskripsi: f['deskripsi'],
            namaUser: f['nama'],
            idCerita: widget.idCerita
          );
        }).toList();

        setState(() {
          loading = false;
          listRating = lR;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
      print('terjadi kesalahan');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return loading ? Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ) : ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(0.0),
      physics: PageScrollPhysics(),
      itemCount: listRating.length,
      itemBuilder: (_, int index) {
        RatingModel r = listRating[index];
        List<Widget> star = [];
        for(int i=0; i<=r.rating; i++) {
          star.add(Icon(Icons.star, color: Colors.yellow.shade800));
        }
        return ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text(r?.deskripsi),
          subtitle: Text(r?.namaUser),
          trailing: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: star,
          ),
        );
      },
    );
  }
}