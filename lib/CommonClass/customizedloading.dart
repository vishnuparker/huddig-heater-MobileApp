// import 'package:flutter/material.dart';
// class customizedloading extends StatelessWidget {
//   final String loadingMessage;

//   const customizedloading({Key key, this.loadingMessage}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//     showDialog<String>(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new WillPopScope(
//               onWillPop: () async => false,
//               child: SimpleDialog(
//                   key: key,
//                   backgroundColor: Colors.black54,
//                   children: <Widget>[
//                     Center(
//                       child: Column(children: [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 10,),
//                         Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
//                       ]),
//                     )
//                   ]
//                   ))
//                   ;
//         });
//   }
// }