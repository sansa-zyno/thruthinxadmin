import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:truthinxadmin/Widgets/VerificationModel.dart';

class ClientsVerified extends StatelessWidget {
  const ClientsVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("user")
          .where("verification", isEqualTo: "VERIFIED")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          int totalDocs = snapshot.data!.docs.length;
          List<DocumentSnapshot> allDocs = snapshot.data!.docs;
          return ListView(
            children: List.generate(totalDocs, (index) {
              String dp = allDocs[index]["dp"];
              String role = allDocs[index]["role"];
              if (dp == "default") {
                dp = "https://image.flaticon.com/icons/png/512/847/847969.png";
              }
              if (role != "Client") {
                return Container();
              }

              return VerificationContainer(
                doc: allDocs[index],
                docID: allDocs[index].id,
                totalRequests: totalDocs,
                requestNumber: index + 1,
                containerColor: Colors.green,
                containerType: "Verified",
                name:
                    "${allDocs[index]["first_name"]} ${allDocs[index]["last_name"]}",
                role: "Client",
                userDp: dp,
                username: "@${allDocs[index]["instagram_username"]}",
              );
            }),
          );
        } else {
          if (snapshot.connectionState != ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.network(
                      "https://assets4.lottiefiles.com/private_files/lf30_LOw4AL.json",
                      height: 200,
                      repeat: false,
                      onLoaded: (LottieComposition comp) {}),
                  SizedBox(
                    height: 10,
                  ),
                  Text("No Clients Found",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}
