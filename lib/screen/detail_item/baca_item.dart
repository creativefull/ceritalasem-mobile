import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../config/api.dart' show urlApi;

class BacaItemView extends StatefulWidget {
  BacaItemView({
    this.title,
    this.url
  });
  final String title;
  final String url;

  @override
  _BacaItemViewState createState() => _BacaItemViewState();
}

class _BacaItemViewState extends State<BacaItemView> {
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(widget.title),
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SliverFillRemaining(
            child: InAppWebView(
              initialOptions: {
                'supportZoom' : false,
                'disallowOverScroll' : false
              },
              initialUrl: urlApi + '/' + widget.url,
              onLoadStart: (InAppWebViewController controller, String url) {
                print("Started ${url}");
                setState(() {

                });
              },
              onProgressChanged: (InAppWebViewController controller, int progressW) {
                setState(() {
                  progress = progressW / 100;
                });
              },
            ),
          )
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //   ]),
          // )
        ],
      )
    );
  }
}