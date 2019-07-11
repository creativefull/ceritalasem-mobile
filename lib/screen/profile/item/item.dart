import 'package:flutter/material.dart';
import './item_model.dart';
import 'package:http/http.dart' as http;
import '../../../config/api.dart';
import '../../home/home_view.dart' show ItemView;

class MyItem extends StatefulWidget {
  MyItemView createState() => MyItemView();
}

class MyItemView extends MyItemModel {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0
      ),
      itemCount: listCerita.length,
      itemBuilder: (_, int index) {
        return ItemView(listCerita[index]);
      },
    );
  }
}

// class ItemView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Card(
//         child: Stack(
//           alignment: AlignmentDirectional.bottomStart,
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage('https://assets-a1.kompasiana.com/items/album/2017/06/02/kawasan-alun-alun-kota-rembang-59305c1a3797730b6b3907e5.jpg?t=o&v=800'),
//                   fit: BoxFit.cover
//                 )
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Flexible(
//                     child: Text('Alun - Alun Rembang Yang Indah', style: TextStyle(
//                       fontSize: 15.0,
//                       color: Colors.white
//                     ), softWrap: true),
//                   ),
//                 ],
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }