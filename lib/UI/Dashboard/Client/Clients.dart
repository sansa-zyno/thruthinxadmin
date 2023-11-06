import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthinxadmin/UI/Dashboard/Client/ClientsInProgress.dart';
import 'package:truthinxadmin/UI/Dashboard/Client/ClientsPending.dart';
import 'package:truthinxadmin/UI/Dashboard/Client/ClientsVerified.dart';

class Clients extends StatelessWidget {
  Clients({Key? key}) : super(key: key);

  final clientPages = [ClientsPending(), ClientInProgress(), ClientsVerified()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "In Progress",
                ),
                Tab(text: "Verified"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: clientPages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
