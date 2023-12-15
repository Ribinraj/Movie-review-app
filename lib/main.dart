// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/Model/commend.dart';
import 'package:picture_pulse/Model/login.dart';
import 'package:picture_pulse/Model/wishlist.dart';

import 'package:picture_pulse/screens/splashscreen.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(AddmovieAdapter());
  await Hive.openBox('addMovie');
  Hive.registerAdapter(LoginAdapter());
  await Hive.openBox('login');
  Hive.registerAdapter(WishlistAdapter());
  await Hive.openBox('wishlist');
  Hive.registerAdapter(CommendAdapter());
  await Hive.openBox('commend');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'picturepulse',
      home: splashScreen(),
    );
  }
}
