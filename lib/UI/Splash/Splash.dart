import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truthinxadmin/UI/Authentication/Login/body.dart';
import 'package:truthinxadmin/UI/Dashboard/Dashboard.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/model.jpeg",
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/Animations/loading.gif",
                )),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                child: Image.asset(
              "assets/logo.png",
            )),
          ),
        ],
      ),
    );
  }
}
