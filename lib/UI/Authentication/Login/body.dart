import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:truthinxadmin/UI/Authentication/ForgotPassword/ForgotPassword.dart';
import 'package:truthinxadmin/UI/Authentication/Login/background.dart';

import 'package:truthinxadmin/UI/Dashboard/Dashboard.dart';
import 'package:truthinxadmin/Widgets/rounded_input_field.dart';
import 'package:truthinxadmin/Widgets/rounded_password_field.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late RoundedLoadingButtonController _btnController;

  String email = "";

  String password = '';

  @override
  void initState() {
    super.initState();

    _btnController = RoundedLoadingButtonController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              SizedBox(height: size.height * 0.04),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedPasswordField(
                hint: "Password",
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: size.height * 0.02),
              RoundedLoadingButton(
                color: Color.fromRGBO(143, 148, 251, 1),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text('    LOGIN    ',
                    style: TextStyle(color: Colors.white)),
                controller: _btnController,
                onPressed: () {
                  loginUser(context);
                },
              ),
              SizedBox(height: size.height * 0.03),
              Divider(
                color: Colors.grey[400],
                endIndent: 40,
                indent: 40,
              ),
              SizedBox(height: size.height * 0.03),
              TextButton(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginUser(context) async {
    if (email.isEmpty || email != "admin@gmail.com") {
      Fluttertoast.showToast(msg: "Please enter a valid Email");
      _btnController.reset();
      return;
    }
    if (password.isEmpty || password.length < 8) {
      Fluttertoast.showToast(msg: "Password is too short!");
      _btnController.reset();
      return;
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .onError((error, stackTrace) {
        _btnController.reset();
        Fluttertoast.showToast(msg: error.toString());
        return Future.value(null);
      });

      _btnController.success();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboard()),
            (route) => false);
      });
    } catch (e) {
      _btnController.error();
      Fluttertoast.showToast(msg: e.toString());
      Timer(Duration(seconds: 3), () {
        _btnController.reset();
      });
    }
  }
}
