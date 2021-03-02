
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ssh/ssh.dart';
// import 'package:secure_control_protocol/scp.dart';
// import 'package:secure_control_protocol/scp_crypto.dart';
// import 'package:secure_control_protocol/scp_device.dart';
// import 'package:secure_control_protocol/scp_message_sender.dart';
// import 'package:secure_control_protocol/scp_response_parser.dart';
// import 'package:secure_control_protocol/scp_status.dart';
// import 'package:secure_control_protocol/util/ip_range.dart';
// import 'package:secure_control_protocol/util/json_storage.dart';
// import 'package:secure_control_protocol/util/test/ip_range_test.dart';
// import 'package:secure_control_protocol/util/test/json_storage_add_test.dart';
// import 'package:secure_control_protocol/util/test/json_storage_read_test.dart';

// class SshServer extends StatefulWidget {
//   @override
//   _SshServerState createState() => new _SshServerState();
// }

// class _SshServerState extends State<SshServer> {
//   String _result = '';
//   List _array;

//   Future<void> onClickCmd() async {
//     var client = new SSHClient(
//       host: '192.168.0.1',
//       port: 22,
//       username: "root",
//       passwordOrKey: "IQANIOT850",
//     );

//     String result;
//     try {
//       result = await client.connect();
//       if (result == "session_connected") result = await client.execute("date");

//       client.disconnect();
//     } on PlatformException catch (e) {
//       print('Error: ${e.code}\nError Message: ${e.message}');
//     }

//     setState(() {
//       _result = result;
//       _array = null;
//     });
//   }

//   Future<void> onClickShell() async {
//     var client = new SSHClient(
//       host: '192.168.0.1',
//       port: 22,
//       username: "sha",
//       passwordOrKey: {

//       },
//     );

//     setState(() {
//       _result = "";
//       _array = null;
//     });

//     try {
//       String result = await client.connect();
//       if (result == "session_connected") {
//         result = await client.startShell(
//             ptyType: "xterm",
//             callback: (dynamic res) {
//               setState(() {
//                 _result += res;
//               });
//             });

//         if (result == "shell_started") {
//           print(await client.writeToShell("echo hello > world\n"));
//           print(await client.writeToShell("cat world\n"));
//           new Future.delayed(
//             const Duration(seconds: 5),
//             () async => await client.closeShell(),
//           );
//         }
//       }
//     } on PlatformException catch (e) {
//       print('Error: ${e.code}\nError Message: ${e.message}');
//     }
//   }

//   Future<void> onClickSFTP() async {
//     var client = new SSHClient(
//       host: '192.168.0.1',
//       port: 22,
//       username: "sha",
//       passwordOrKey: "Password01.",
//     );

//     try {
//       String result = await client.connect();
//       if (result == "session_connected") {

//         // Scp scp = new Scp();
      
//         result = await client.connectSFTP();
//         if (result == "sftp_connected") {
//           var array = await client.sftpLs();
//           setState(() {
//             _result = result;
//             _array = array;
//           });

//           print(await client.sftpMkdir("testsftp"));
//           print(await client.sftpRename(
//             oldPath: "testsftp",
//             newPath: "testsftprename",
//           ));
//           print(await client.sftpRmdir("testsftprename"));

//           //Directory tempDir = await getTemporaryDirectory();
//           String tempPath = "/mnt/internal_storage/";
//           var filePath = await client.sftpDownload(
//             path: "testupload",
//             toPath: tempPath,
//             callback: (progress) async {
//               print(progress);
//               // if (progress == 20) await client.sftpCancelDownload();
//             },
//           );

//           print(await client.sftpRm("testupload"));

//           print(await client.sftpUpload(
//             path: filePath,
//             toPath: ".",
//             callback: (progress) async {
//               print(progress);
//               // if (progress == 30) await client.sftpCancelUpload();
//             },
//           ));
//           print(await client.disconnectSFTP());

//           client.disconnect();
//         }
//       }
//     } on PlatformException catch (e) {
//       print('Error: ${e.code}\nError Message: ${e.message}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget renderButtons() {
//       return ButtonTheme(
//         padding: EdgeInsets.all(5.0),
//         child: ButtonBar(
//           children: <Widget>[
//             FlatButton(
//               child: Text(
//                 'Test command',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: onClickCmd,
//               color: Colors.blue,
//             ),
//             FlatButton(
//               child: Text(
//                 'Test shell',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: onClickShell,
//               color: Colors.blue,
//             ),
//             FlatButton(
//               child: Text(
//                 'Test SFTP',
//                 style: TextStyle(color: Colors.white),
//               ),
//               onPressed: onClickSFTP,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       );
//     }

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.yellow,
//           title: const Text('Gateway Connection'),
//         ),
//         body: ListView(
//           shrinkWrap: true,
//           padding: EdgeInsets.all(15.0),
//           children: <Widget>[
//             Text("connect "),
//             renderButtons(),
//             Text(_result),
//             _array != null && _array.length > 0
//                 ? Column(
//                     children: _array.map((f) {
//                       return Text(
//                           "${f["filename"]} ${f["isDirectory"]} ${f["modificationDate"]} ${f["lastAccess"]} ${f["fileSize"]} ${f["ownerUserID"]} ${f["ownerGroupID"]} ${f["permissions"]} ${f["flags"]}");
//                     }).toList(),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }