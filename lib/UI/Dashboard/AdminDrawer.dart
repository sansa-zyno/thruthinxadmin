import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truthinxadmin/UI/Authentication/Login/body.dart';
import 'package:truthinxadmin/UI/Dashboard/ChangePassword.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Admin"),
            accountEmail: Text(FirebaseAuth.instance.currentUser!.email!),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Center(
                child: Image.asset(
                  "assets/admin.png",
                  height: 40,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.vpn_key_rounded),
            title: Text("Change Password"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          Expanded(child: Center()),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            },
          ),
          SizedBox(height: 40)
        ],
      ),
    );
  }
}
