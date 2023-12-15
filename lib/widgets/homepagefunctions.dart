// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picture_pulse/Model/wishlist.dart';
import 'package:picture_pulse/screens/login.dart';
import 'package:picture_pulse/screens/profile/profile.dart';
import 'package:picture_pulse/screens/wishlist.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

// searchbutton
Widget searchButton({
  required VoidCallback onPressed,
  required String buttonText,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 119, 198, 206),
      foregroundColor: Color.fromARGB(255, 0, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Row(
      children: [
        Icon(Mdi.movieFilterOutline),
        SizedBox(
          width: 5,
        ),
        Text(
          buttonText,
          style: GoogleFonts.oswald(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

//drawer
class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late Box loginDatabox;
  int? storedindex = 0;
  @override
  void initState() {
    super.initState();
    loginDatabox = Hive.box('login');
    _getstoredindex().then((value) {
      setState(() {
        storedindex = value;
      });
    });
  }

  Future<int?> _getstoredindex() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    return sharedpref.getInt('userIndex');
  }

  @override
  Widget build(BuildContext context) {
    final login = loginDatabox.getAt(storedindex!);
    final imageFile = File(login.imageUrl.toString());
    return Drawer(
      backgroundColor: customblueColor(),
      child: ListView(
        children: [
          SizedBox(
            height: 70,
            child: DrawerHeader(
              child: Text(
                'Home',
                style: GoogleFonts.oswald(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 65,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 241, 241),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 2, color: custombordercolor())),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: imageFile.existsSync()
                      ? Image.file(
                          File(
                            login.imageUrl.toString(),
                          ),
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.camera,
                          size: 50,
                          color: Colors.black,
                        )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: customblueColor(),
                border: Border.all(width: 1, color: custombordercolor()),
                borderRadius: BorderRadius.circular(4)),
            height: 40,
            width: 250,
            child: Center(child: subtitle('Hii..   ${login.username}', 20)),
          ),
          ListTile(
            title: Row(children: [
              Icon(
                Mdi.accountTie,
                size: 32,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              subtitle('Profile', 20, textColor: Colors.black)
            ]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => profileScreen(),
              ));
            },
          ),
          ListTile(
            title: Row(children: [
              Icon(
                Mdi.heartBoxOutline,
                size: 32,
                color: Colors.black,
              ),
              SizedBox(
                width: 5,
              ),
              subtitle('Wishlist', 20, textColor: Colors.black)
            ]),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WishlistScreen(),
              ));
            },
          ),
          ListTile(
              title: Row(children: [
                Icon(
                  Mdi.logout,
                  size: 32,
                  color: const Color.fromARGB(255, 177, 43, 34),
                ),
                SizedBox(
                  width: 5,
                ),
                subtitle('Logout', 20,
                    textColor: const Color.fromARGB(255, 168, 44, 35))
              ]),
              onTap: () {
                showDialog(
                  context: context,
                  // ignore: avoid_types_as_parameter_names
                  builder: (context) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure want to logout"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          final _sharedpref =
                              await SharedPreferences.getInstance();
                          await _sharedpref.clear();

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (ctx1) => loginScreen()),
                              (route) => false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            createCustomSnackBar(
                                text: 'Logouted successfully',
                                backgroundColor: Colors.red),
                          );
                        },
                        child: const Text("yes"),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
//imagefullview

void showFullScreenImageDialog(BuildContext context, String imagePath) {
  showDialog(
    context: context,
    builder: (context) => FullScreenImageDialog(imagePath: imagePath),
  );
}

class FullScreenImageDialog extends StatelessWidget {
  final String imagePath;

  const FullScreenImageDialog({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          width: 500,
          height: 500,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

// favorite
class FavoriteClass extends StatefulWidget {
  final int? index;

  const FavoriteClass({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<FavoriteClass> createState() => _FavoriteClsState();
}

class _FavoriteClsState extends State<FavoriteClass> {
  int? userIndex;
  late Box wishlistBox;

  @override
  void initState() {
    wishlistBox = Hive.box('wishlist');
    getUserIndex().then((value) {
      setState(() {
        userIndex = value;
      });
    });
    super.initState();
  }

  Future<int?> getUserIndex() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('userIndex') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    int favoriteIndex = widget.index ?? 0;
    return ValueListenableBuilder(
        valueListenable: wishlistBox.listenable(),
        builder: (context, value, child) {
          return IconButton(
            splashRadius: 20,
            onPressed: () {
              addToWishlist(favoriteIndex);
            },
            icon: buildFavoriteIcon(),
          );
        });
  }

  Icon buildFavoriteIcon() {
    return Icon(
      wishlistBox.values.any((item) =>
              item.userid == userIndex && item.movieid == widget.index)
          ? Icons.favorite
          : Icons.favorite_border,
      color: Colors.red,
    );
  }

  void addToWishlist(int movieIndex) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    int userIndex = sharedpref.getInt('userIndex') ?? 0;

    List wishlistItems = wishlistBox.values.toList();

    int existingIndex = wishlistItems.indexWhere(
      (item) => item.userid == userIndex && item.movieid == movieIndex,
    );
    setState(() {
      if (existingIndex != -1) {
        wishlistBox.deleteAt(existingIndex);
      } else {
        Wishlist wishlistItem =
            Wishlist(userid: userIndex, movieid: movieIndex);
        wishlistBox.add(wishlistItem);
      }
    });
  }
}
