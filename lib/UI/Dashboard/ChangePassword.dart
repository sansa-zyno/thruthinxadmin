import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:truthinxadmin/UI/Authentication/Login/background.dart';
import 'package:truthinxadmin/Widgets/rounded_input_field.dart';
import 'package:truthinxadmin/Widgets/rounded_password_field.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late RoundedLoadingButtonController _btnController;

  String currentPassword = '';
  String newPassword = "";
  String conPassword = "";
  @override
  void initState() {
    super.initState();

    _btnController = RoundedLoadingButtonController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(
          "Update Password",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.01),
              SizedBox(height: size.height * 0.04),
              RoundedPasswordField(
                hint: "Current Password",
                onChanged: (value) {
                  currentPassword = value;
                },
              ),
              RoundedPasswordField(
                hint: "New Password",
                onChanged: (value) {
                  newPassword = value;
                },
              ),
              RoundedPasswordField(
                hint: "Confirm Password",
                onChanged: (value) {
                  conPassword = value;
                },
              ),
              SizedBox(height: size.height * 0.02),
              RoundedLoadingButton(
                color: Color.fromRGBO(143, 148, 251, 1),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text('    Update    ',
                    style: TextStyle(color: Colors.white)),
                controller: _btnController,
                onPressed: updatePassword,
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  updatePassword() async {
    if (currentPassword.isEmpty || newPassword.isEmpty || conPassword.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields!");
      _btnController.reset();
      return;
    }
    if (newPassword.trim().length < 8) {
      Fluttertoast.showToast(msg: "Password is too short");
      _btnController.reset();
      return;
    }
    if (newPassword.trim() != conPassword.trim()) {
      Fluttertoast.showToast(msg: "New password's fields does not match");
      _btnController.reset();
      return;
    }
    Fluttertoast.showToast(msg: "Processing...");
    bool userVerified = await validatePassword(currentPassword.trim());
    if (userVerified) {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      await firebaseUser!.updatePassword(newPassword.trim());
      Fluttertoast.showToast(msg: "Password changed successfully!");
      _btnController.success();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
        Navigator.pop(context);
      });
    } else {
      Fluttertoast.showToast(msg: "Current User Password is incorrect!");
      _btnController.reset();
    }
  }

  Future<bool> validatePassword(String password) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser!.email!, password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
