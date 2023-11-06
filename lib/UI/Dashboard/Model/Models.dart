import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelInProgress.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelPending.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelVerified.dart';

class Models extends StatelessWidget {
  Models({Key? key}) : super(key: key);
  List<Widget> modelPages = [
    ModelsPending(),
    ModelsInProgress(),
    ModelsVerified()
  ];
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
                children: modelPages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
