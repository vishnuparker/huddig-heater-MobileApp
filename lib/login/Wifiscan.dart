// import 'dart:async';


// import 'package:flutter/material.dart';
// import 'package:parker_mobile_framework/login/SshServer.dart';

// import 'package:wifi/wifi.dart';

// class Wifiscan extends StatefulWidget {
//   @override
//   _WifiscanState createState() => new _WifiscanState();
// }

// class _WifiscanState extends State<Wifiscan> {
//   // ignore: close_sinks

//   String _wifiName = 'Connect Wifi  ssid.';
//   String _ip = 'ipaddress';
//   List ssidList = [];
//   String ssid ;
//   String password ;
//   int level = 0;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       loadData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Wifi'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           padding: EdgeInsets.all(8.0),
//           itemCount: ssidList.length + 1,
//           itemBuilder: (BuildContext context, int index) {
//             return itemSSID(index);
//           },
//         ),
//       ),
//     );
//   }

//   Widget itemSSID(index) {
//     if (index == 0) {
//       return Column(
//         children: [
//           Text("connected wifi connection"),
//           Row(
//             children: <Widget>[
//               RaisedButton(
//                 child: Text('ssid'),
//                 onPressed: _getWifiName,
//               ),
//               Offstage(
//                 offstage: level == 0,
//                 child: Icon(Icons.wifi),
//               ),
//               Text(_wifiName),
//             ],
//           ),
//           Row(
//             children: <Widget>[
//               RaisedButton(
//                 child: Text('ip'),
//                 onPressed: _getIP,
//               ),
//               Text(_ip),
//             ],
//           ),
//           Row(children: <Widget>[
//             Center(
//               child: Text(
//                 "Avilable wifi device",
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ]),
//           TextField(
//             decoration: InputDecoration(
//               border: UnderlineInputBorder(),
//               filled: true,
//               icon: Icon(Icons.wifi),
//               hintText: 'Gateway  ssid',
//               labelText: 'ssid',
//             ),
//             keyboardType: TextInputType.text,
//             onChanged: (value) {
//               ssid = value;
//             },
//           ),
//           TextField(
//             decoration: InputDecoration(
//               border: UnderlineInputBorder(),
//               filled: true,
//               icon: Icon(Icons.lock_outline),
//               hintText: 'Gateway password',
//               labelText: 'password',
//             ),
//             keyboardType: TextInputType.text,
//             onChanged: (value) {
//               password = value;
//             },
//           ),
//            RaisedButton(
//             child: Text('Connect to Gateway'),
//             onPressed: connection,
//           ),
//         ],
//       );
//     } else {
//       return Column(children: <Widget>[
//         ListTile(
//           leading: Icon(Icons.wifi),
//           trailing: Icon(Icons.arrow_right),
//           title: Text(
//             ssidList[index - 1].ssid,
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: 16.0,
//             ),
//           ),
//           dense: true,
//         ),
//         Divider(),
//       ]);
//     }
//   }

//   void loadData() async {
//     Wifi.list('').then((list) {
//       setState(() {
//         ssidList = list;
//       });
//     });
//   }

//   Future<Null> _getWifiName() async {
//     int l = await Wifi.level;
//     String wifiName = await Wifi.ssid;
//     setState(() {
//       level = l;
//       _wifiName = wifiName;
//     });
//   }

//   Future<Null> _getIP() async {
//     String ip = await Wifi.ip;
//     setState(() {
//       _ip = ip;
//     });
//   }


  
//    connection(){
//       Navigator.push(
//                 context,
//                MaterialPageRoute(builder: (context) => SshServer()),
//               );

//    }
// }