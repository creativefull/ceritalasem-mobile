import 'package:flutter/material.dart';
import './profile_model.dart';
import './item/item.dart';

class ProfileView extends ProfileModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isAuth ? null : FloatingActionButton.extended(
        icon: Icon(Icons.vpn_key),
        backgroundColor: Colors.green,
        label: Text('Daftar / Masuk'),
        onPressed: () {
          Navigator.of(context).pushNamed('/splash');
        },
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Profil Kamu'),
              centerTitle: true,
            ),
          ),
          loading ? SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ) : !isAuth ? SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Text('Untuk melihat halaman ini, Silahkan Login terlebih dahulu', style: TextStyle(
                  fontSize: 30.0
                ), textAlign: TextAlign.center,),
              ),
            ),
          ) : SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Theme.of(context).primaryColor.withOpacity(.2),
                              child: Text(profile.nama.substring(0,1), style: TextStyle(
                                fontSize: 30.0,
                                color: Theme.of(context).primaryColor,
                                fontFamily: 'Raleway Bold'
                              )),
                            ),
                            SizedBox(height: 20.0),
                            Text(profile.nama, style: TextStyle(
                              fontSize: 20.0
                            )),
                            // Text('@andrew', style: TextStyle(
                            //   fontSize: 10.0
                            // )),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListStatistik(stat),
                      ),
                      SizedBox(height: 30.0)
                    ],
                  )
                )
              )
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Postingan Kamu', style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).primaryColor
                )),
              ),
              Divider(),
              MyItem()
            ])
          )
        ],
      )
    );
  }
}

class ListStatistik extends StatelessWidget {
  final Stat stat;
  ListStatistik(this.stat);

  @override
  Widget build(BuildContext context) {
    return stat == null ? Container(
      child: Center(
        child: CircularProgressIndicator(),
      )
    ) : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.favorite, color: Colors.green,size: 32.0),
            SizedBox(height: 5.0),
            Text(stat.approve.toString(), style: TextStyle(
              fontSize: 30.0,
              color: Colors.green.withOpacity(.8),
              fontFamily: 'Raleway Bold'
            )),
            Text('Di Setujui')
          ],
        ),
        SizedBox(width: 10.0),
        Column(
          children: <Widget>[
            Icon(Icons.cancel, color: Colors.red, size: 32.0),
            SizedBox(height: 5.0),
            Text(stat.disapprove.toString(), style: TextStyle(
              fontSize: 30.0,
              color: Colors.red.withOpacity(.8),
              fontFamily: 'Raleway Bold'
            )),
            Text('Di Tolak')
          ],
        ),
        SizedBox(width: 10.0),
       Column(
          children: <Widget>[
            Icon(Icons.watch_later, color: Colors.purple, size: 32.0),
            SizedBox(height: 5.0),
            Text(stat.pending.toString(), style: TextStyle(
              fontSize: 30.0,
              color: Colors.purple.withOpacity(.8),
              fontFamily: 'Raleway Bold'
            )),
            Text('Pending')
          ],
        )
      ],
    );
  }
}