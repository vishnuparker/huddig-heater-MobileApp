import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/login/Authentication.dart';
import 'package:parker_mobile_framework/login/Login.dart';
import 'package:parker_mobile_framework/login/SignOut.dart';



void main() => runApp(MyApp());
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      //  initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
         '/Authentication': (BuildContext context) => Authentication(),
         '/login': (BuildContext context) => Login(),
         '/signOut':(BuildContext context) =>SignOut(),
        //  '/Aboutfragment':(context) =>Aboutfragment(),
        // '/Wifiscan':(context)=> Wifiscan(),
        
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> startTime() async {
    const Duration _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Authentication');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Image.asset('assets/images/parker.jpg'),
      ),
    );
  }
}