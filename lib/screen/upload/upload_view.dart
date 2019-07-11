import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './upload_model.dart';

class UploadPageView extends UploadPageModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Posting Cerita', style: TextStyle(
                fontFamily: 'Raleway Light',
                fontWeight: FontWeight.w400
              )),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () => getSource(),
                    child: MenuUtamaItems(
                      colorBox: Colors.green.withOpacity(.3),
                      title: 'Foto',
                      icon: Icons.image,
                      colorIcon: Colors.green,
                    ),
                  ),
                  InkWell(
                    onTap: getVideo,
                    child: MenuUtamaItems(
                      colorBox: Colors.orange.withOpacity(.3),
                      title: 'Video',
                      icon: Icons.videocam,
                      colorIcon: Colors.orange,
                    ),
                  ),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}

class MenuUtamaItems extends StatelessWidget {
  MenuUtamaItems({this.title, this.icon, this.colorBox, this.colorIcon});
  final String title;
  final IconData icon;
  final Color colorBox, colorIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: colorBox,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: colorIcon,
              size: 50.0,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}