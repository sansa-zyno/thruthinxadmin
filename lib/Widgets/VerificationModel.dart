import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:truthinxadmin/UI/Dashboard/Client/ClientDetails.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelDetails.dart/ModelDetail.dart';

class VerificationContainer extends StatelessWidget {
  final String? name;
  final String? username;
  final String? role;
  final int? totalRequests;
  final int? requestNumber;
  final Color? containerColor;
  final String? containerType;
  final String? userDp;
  final String docID;
  final DocumentSnapshot doc;
  VerificationContainer(
      {this.userDp,
      required this.doc,
      required this.docID,
      this.name,
      this.username,
      this.role,
      this.requestNumber,
      this.totalRequests,
      this.containerColor,
      this.containerType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Container(
              height: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                color: containerColor,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    containerType!,
                    style: TextStyle(
                        color: containerColor, fontWeight: FontWeight.bold),
                  ),
                  Text("$requestNumber/$totalRequests",
                      style: TextStyle(color: Colors.grey))
                ],
              )),
          SizedBox(height: 20),
          ListTile(
            onTap: () {
              if (containerType == "Pending") {
                verifyUser(context, false);
              }
              if (containerType == "Verified") {
                verifyUser(context, true);
              }
            },
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 30,
              backgroundImage: NetworkImage(userDp!),
            ),
            title: Text(name!),
            subtitle: Text(username!),
            trailing: Icon(Icons.more_horiz_rounded),
          ),
          SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Row(
                children: [
                  Text(
                    containerType == "Verified" ? "" : "Requested as ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    role!,
                    style: TextStyle(
                        color: containerColor, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  verifyUser(context, bool isVerified) async {
    if (role != "Client") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ModelDetails(modelDetail: doc, isVerified: isVerified),
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClientDetails(
                  doc: doc, dp: userDp!, isVerified: isVerified)));
    }
  }
}
