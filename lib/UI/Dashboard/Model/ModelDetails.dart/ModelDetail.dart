import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:truthinxadmin/Services/NotificationServices.dart';

import 'package:truthinxadmin/UI/Dashboard/Model/ModelDetails.dart/InstaProfileWebView.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelDetails.dart/ModelAttributes.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelDetails.dart/ModelCategories.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelDetails.dart/ModelSkills.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/ModelDetails.dart/Portfolio.dart';
import 'package:truthinxadmin/Widgets/RoundedTabBarIndicator.dart';

class ModelDetails extends StatefulWidget {
  final DocumentSnapshot? modelDetail;
  final bool? isVerified;

  ModelDetails({this.modelDetail, this.isVerified});

  @override
  _ModelDetailsState createState() => _ModelDetailsState();
}

class _ModelDetailsState extends State<ModelDetails> {
  TextEditingController _proposalController = TextEditingController();

  @override
  void dispose() {
    _proposalController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xFF28201A),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Color(0xFFA66234),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ]),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: AvatarGlow(
                              animate: true,
                              glowColor: Color(0xFFA66234),
                              endRadius: 90.0,
                              duration: Duration(milliseconds: 2000),
                              repeat: true,
                              showTwoGlows: true,
                              repeatPauseDuration: Duration(milliseconds: 10),
                              child: Hero(
                                tag: widget.modelDetail.hashCode,
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: widget.modelDetail!["dp"] ==
                                          "default"
                                      ? AssetImage('assets/userP.png')
                                      : NetworkImage(widget.modelDetail!["dp"])
                                          as ImageProvider,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Center()),
                      ],
                    ),
                  ),
                  Text(
                    "${widget.modelDetail!["first_name"]}  ${widget.modelDetail!["last_name"]}"
                        .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: GoogleFonts.varelaRound().fontFamily,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  // widget.modelDetail["verification"] == "VERIFIED"
                  //     ?
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_rounded,
                                color: Color(0xFF7C7671)),
                            SizedBox(width: 5),
                            Text(
                              widget.modelDetail!["city"],
                              style: TextStyle(
                                color: Color(0xFF7C7671),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.isVerified!
                                ? Card(
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.750,
                                      height: 50,
                                      child: InkWell(
                                          onTap: revokeVerification,
                                          child: Center(
                                            child: Text("Revoke Verification",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: GoogleFonts
                                                            .varelaRound()
                                                        .fontFamily)),
                                          )),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Card(
                                        color: Color(0xFFF08740),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50,
                                          height: 50,
                                          child: InkWell(
                                              onTap: verifyModel,
                                              child: Center(
                                                child: Text("Verify",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: GoogleFonts
                                                                .varelaRound()
                                                            .fontFamily)),
                                              )),
                                        ),
                                      ),
                                      Card(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          height: 50,
                                          child: InkWell(
                                              onTap: declineModel,
                                              child: Center(
                                                child: Text("Decline",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: GoogleFonts
                                                                .varelaRound()
                                                            .fontFamily)),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                            AvatarGlow(
                              animate: true,
                              glowColor: Color(0xFFA66234),
                              endRadius: 30.0,
                              duration: Duration(milliseconds: 2000),
                              repeat: true,
                              showTwoGlows: true,
                              repeatPauseDuration: Duration(milliseconds: 10),
                              child: IconButton(
                                  icon: Image.asset(
                                    "assets/instagram.png",
                                    height: 24,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InstaProfileWebView(
                                                    "https://www.instagram.com/${widget.modelDetail!["instagram_username"]}/")));
                                  }),
                            ),
                          ],
                        ),
                        TabBar(
                          indicatorSize: TabBarIndicatorSize.values[1],
                          //indicatorPadding: EdgeInsets.only(right: 40),
                          isScrollable: true,
                          indicatorColor: Colors.white,
                          indicator: RoundUnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 3.5,
                                color: Color(0xFFF08740),
                              ),
                              insets: EdgeInsets.only(right: 25)),

                          tabs: [
                            Tab(
                              child: Row(
                                children: [Text("Portfolio")],
                              ),
                            ),
                            Tab(
                              child: Row(
                                children: [Text("Categories")],
                              ),
                            ),
                            Tab(
                              child: Row(
                                children: [Text("Attributes")],
                              ),
                            ),
                            Tab(
                              child: Row(
                                children: [Text("Skills")],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            Portfolio(
                              bestPhotos: widget.modelDetail!["bestPhotos"],
                            ),
                            ModelCategories(
                                categories: widget.modelDetail!["categories"]),
                            ModelAttributes(
                              attributes: widget.modelDetail!["attributes"],
                            ),
                            ModelSkills(
                              skills: widget.modelDetail!["skills"],
                            ),
                          ]),
                        )
                      ],
                    ),
                  )
                  //       : Column(
                  //           children: [
                  //             Divider(),
                  //             Card(
                  //               color: Color(0xFFF08740),
                  //               shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(10),
                  //               ),
                  //               child: Container(
                  //                 width: MediaQuery.of(context).size.width * 0.75,
                  //                 height: 50,
                  //                 child: Row(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Icon(Icons.verified_user_outlined),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Text("User not verified!")
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void revokeVerification() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.modelDetail!.id)
        .update({"verification": "submitted"});
    sendNotifications(
      bodyText:
          "Your profile verification has been revoked. Dont worry our team will inform you soon about your profile status",
      id: widget.modelDetail!.id,
      title: "Important!",
    );
    Fluttertoast.showToast(msg: "Verification Revoked");
    Navigator.pop(context);
  }

  void verifyModel() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.modelDetail!.id)
        .update({"verification": "VERIFIED"});
    sendNotifications(
      bodyText:
          "Your profile has been approved. You can now use exclusive features on our app",
      id: widget.modelDetail!.id,
      title: "Congratulations!",
    );
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: [
                Lottie.asset("assets/Animations/verified.json",
                    repeat: false, height: 170),
                Text(
                  "Success!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text("User has been verified."),
                SizedBox(
                  height: 10,
                ),
                CupertinoButton.filled(
                    child: Text("Done"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
              ],
            ),
          );
        });
  }

  void declineModel() async {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Decline!"),
            content: Text(
                "User will be notified that his/her request has been declined."),
            actions: [
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text("Decline"),
                isDestructiveAction: true,
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("user")
                      .doc(widget.modelDetail!.id)
                      .update({"verification": "UNKNOWN"});

                  sendNotifications(
                    bodyText:
                        "Verification Denied. Please read the instructions carefully and try again.",
                    id: widget.modelDetail!.id,
                    title: "We are sorry!",
                  );

                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
