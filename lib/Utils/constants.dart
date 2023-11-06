import 'package:flutter_dotenv/flutter_dotenv.dart';

final postNotificationURL = "https://fcm.googleapis.com/fcm/send";
final headers = {
  'content-type': 'application/json',
  'Authorization': dotenv.env["authServerKeyFirebase"]!
};
