// ignore_for_file: prefer_const_constructors, camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:picture_pulse/main.dart';
import 'package:picture_pulse/screens/home.dart';
import 'package:picture_pulse/screens/login.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    checkUserLoggedin();
    logIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 120, bottom: 90),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
            border: Border.all(width: 4, color: customblueColor())),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 300,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: customblueColor()),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                image: DecorationImage(
                  image: AssetImage("assets/images/Movies.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            titlelogo(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'unlock the magic of movies',
                  style: GoogleFonts.teko(
                      color: Color.fromARGB(255, 237, 228, 228),
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logIn() async {
    await Future.delayed(Duration(seconds: 3));

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return loginScreen();
    }));
  }

  Future<void> checkUserLoggedin() async {
    final _sharedpref = await SharedPreferences.getInstance();
    final _userloggedIn = _sharedpref.getBool(SAVE_KEY_NAME);
    if (_userloggedIn == null || _userloggedIn == false) {
      logIn();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => homeScreen()));
    }
  }
}
