import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:truthinxadmin/Services/NotificationServices.dart';
import 'package:truthinxadmin/Widgets/ClientDetailTile.dart';

// ignore: must_be_immutable
class ClientDetails extends StatefulWidget {
  final DocumentSnapshot? doc;
  final bool? isVerified;
  final String? dp;
  ClientDetails({this.doc, this.dp, this.isVerified});

  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  final Color screenColor = Colors.blueGrey[900]!;

  final String nA = "Not Provided";

  String clientRole = "";

  @override
  Widget build(BuildContext context) {
    clientRole = widget.doc!["client_role"];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: screenColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          "Clients's Details",
          style: TextStyle(color: screenColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
          child: ListView(
            children: [
              ListTile(
                leading: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.dp!), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                ),
                subtitle: Text("@${widget.doc!["instagram_username"]}"),
                trailing: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text("Client"),
                    )
                  ],
                ),
                title: Text(
                    "${widget.doc!["first_name"]} ${widget.doc!["last_name"]}",
                    style: TextStyle(
                        color: screenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 30),
              Divider(),
              ClientDetailTile(
                icon: Icons.email,
                title: widget.doc!["email"],
                subtitle: "Email",
              ),
              ClientDetailTile(
                icon: Icons.attachment_rounded,
                title: widget.doc!["apt_unit_no"],
                subtitle: "APT Number",
              ),
              clientRole == "business"
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClientDetailTile(
                          icon: Icons.phone_enabled_rounded,
                          title: widget.doc!["cell_no"],
                          subtitle: "Cell no",
                        ),
                        ClientDetailTile(
                          icon: Icons.phone_enabled_rounded,
                          title: widget.doc!["extra_cellno"],
                          subtitle: "Extra Cell no",
                        ),
                        ClientDetailTile(
                          icon: Icons.phone_enabled_rounded,
                          title: widget.doc!["direct_b_no"],
                          subtitle: "Business no",
                        ),
                        ClientDetailTile(
                          icon: Icons.attach_email_rounded,
                          title: widget.doc!["buisness_email"],
                          subtitle: "Business Email",
                        ),
                      ],
                    )
                  : ClientDetailTile(
                      icon: Icons.phone,
                      title: widget.doc!["phone_no"],
                      subtitle: "Phone",
                    ),
              ClientDetailTile(
                icon: Icons.person_pin,
                title: toBeginningOfSentenceCase(clientRole),
                subtitle: "Client Role",
              ),
              ClientDetailTile(
                icon: Icons.date_range_rounded,
                title: widget.doc!["dob"],
                subtitle: "Date of Birth",
              ),
              ClientDetailTile(
                icon: Icons.face_rounded,
                title: "@${widget.doc!["faceook_username"]}",
                subtitle: "Facebook username",
              ),
              ClientDetailTile(
                icon: Icons.house_rounded,
                title: widget.doc!["house_no"],
                subtitle: "House No",
              ),
              ClientDetailTile(
                icon: Icons.place_rounded,
                title: widget.doc!["state"],
                subtitle: "State",
              ),
              ClientDetailTile(
                icon: Icons.public_rounded,
                title: widget.doc!["bus_web_url"],
                subtitle: "Business Web Url",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Image Verification",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(widget.dp!),
                        radius: 50,
                      ),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text("Profile\nPicture"),
                      ))
                    ],
                  ),
                  Image.network(
                    "https://image.flaticon.com/icons/png/512/274/274966.png",
                    height: 30,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage:
                            NetworkImage(widget.doc!["verif_image"]),
                        radius: 50,
                      ),
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Verification\nImage",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: !widget.isVerified!,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400]!,
                                spreadRadius: 5,
                                blurRadius: 10)
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            verifyUser(context);
                          },
                          child: Center(
                            child: Text(
                              "Verify",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400]!,
                              spreadRadius: 5,
                              blurRadius: 10)
                        ],
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                      child: InkWell(
                        onTap: () {
                          declineUser(context);
                        },
                        child: Icon(
                          Icons.delete_sweep_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: widget.isVerified!,
                child: Card(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.750,
                    height: 50,
                    child: InkWell(
                        onTap: revokeVerification,
                        child: Center(
                          child: Text("Revoke Verification",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                      GoogleFonts.varelaRound().fontFamily)),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void revokeVerification() async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.doc!.id)
        .update({"verification": "submitted"});
    sendNotifications(
      bodyText:
          "Your profile verification has been revoked. Dont worry our team will inform you soon about your profile status",
      id: widget.doc!.id,
      title: "Important!",
    );
    Fluttertoast.showToast(msg: "Verification Revoked");
    Navigator.pop(context);
  }

  void verifyUser(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.doc!.id)
        .update({"verification": "VERIFIED"});
    sendNotifications(
      bodyText:
          "Your profile has been approved. You can now use exclusive features on our app",
      id: widget.doc!.id,
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

  void declineUser(BuildContext context) {
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
                      .doc(widget.doc!.id)
                      .update({"verification": "UNKNOWN"});
                  sendNotifications(
                    bodyText:
                        "Verification Denied. Please read the instructions carefully and try again.",
                    id: widget.doc!.id,
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
