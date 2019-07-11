import 'package:flutter/material.dart';
import './upload_model.dart';

class DetailUploadView extends DetailUploadModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: kirimData,
        backgroundColor: Colors.green,
        icon: Icon(Icons.navigate_next, color: Colors.white),
        label: Text('Posting Sekarang', style: TextStyle(
          color: Colors.white
        ))
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: cover != null ? FlexibleSpaceBar(
              background: Image(
                image: FileImage(cover),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
            ) : FlexibleSpaceBar(
              centerTitle: true,
              title: FlatButton.icon(
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text('Cover Cerita', style: TextStyle(
                  color: Colors.white
                )),
                onPressed: customCoverCerita,
              ),
            ),
          ),
          loading ? SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ) : SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Judul', style: TextStyle(
                  fontSize: 20.0
                )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: judul,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Judul cerita kamu tidak boleh kosong ya';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Judul cerita',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Cerita Singkat', style: TextStyle(
                  fontSize: 20.0
                )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: ceritaSingkat,
                  maxLines: 10,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Cerita singkat kamu tidak boleh kosong ya';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Cerita Singkat kamu di sini ya',
                    border: OutlineInputBorder()
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Cerita Lengkap', style: TextStyle(
                  fontSize: 20.0
                )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: openTextEditor,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.mode_edit, color: Colors.blue),
                      SizedBox(width: 10.0),
                      Text('Tambahkan Cerita Lengkap Disini')
                    ],
                  ),
                )
              ),
              // Container(
              //   padding: EdgeInsets.all(20.0),
              //   child: Text('Kategori', style: TextStyle(
              //     fontSize: 20.0
              //   )),
              // ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 20.0),
              //   child: InkWell(
              //     onTap: getKategori,
              //     child: Row(
              //       children: <Widget>[
              //         Icon(Icons.confirmation_number, color: Colors.green),
              //         SizedBox(width: 10.0),
              //         Text(kategori != null ? kategori : 'Pilih Kategori')
              //       ],
              //     ),
              //   )
              // ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Lokasi', style: TextStyle(
                  fontSize: 20.0
                )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 10.0),
                      Text('${widget.lokasi.namaLokasi} - ${widget.kecamatan.namaKecamatan}')
                    ],
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text('Video', style: TextStyle(
                  fontSize: 20.0
                )),
              ),
              video == null ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: getVideo,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera_roll, color: Colors.red),
                      SizedBox(width: 10.0),
                      Text('Upload Video')
                    ],
                  ),
                )
              ) : Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  child: SizedBox(
                    width: 64.0,
                    height: 200.0,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.green.withOpacity(.2),
                          child: Center(child: Text('Ada video')),
                        ),
                        Flexible(
                          child: Row(
                            children: <Widget>[
                              FlatButton.icon(
                                color: Colors.red.withOpacity(.2),
                                icon: Icon(Icons.remove_circle),
                                label: Text('Hapus'),
                                onPressed: hapusVideo,
                              )
                            ],
                          ),
                        )
                      ]
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80.0)
            ]),
          )
        ],
      ),
    );
  }
}