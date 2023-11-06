import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truthinxadmin/UI/Splash/Splash.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await DotEnv.load(fileName: ".env");
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Truthin-X Admin',
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        scaffoldBackgroundColor: Colors.grey[850],
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}
