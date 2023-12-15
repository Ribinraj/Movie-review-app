// ignore_for_file: camel_case_types, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:picture_pulse/Model/login.dart';
import 'package:picture_pulse/screens/profile/editprofile.dart';
import 'package:picture_pulse/screens/login.dart';
import 'package:picture_pulse/screens/wishlist.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  late Box loginDatabox;
  int? storedindex;
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

  void updateprofileinfo(Login updatedLogin) {
    loginDatabox.putAt(storedindex!, updatedLogin);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final login = loginDatabox.getAt(storedindex!);
    final imageFile = File(login.imageUrl.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: subtitle('P r o f i l e', 20, textColor: customblueColor()),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
              color: customblueColor(),
              border: Border.all(width: 2, color: custombordercolor()),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100,
                height: 100,
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
              Container(
                decoration: BoxDecoration(
                    color: customblueColor(),
                    border: Border.all(width: 1, color: custombordercolor()),
                    borderRadius: BorderRadius.circular(4)),
                height: 40,
                width: 250,
                child: Center(child: subtitle('${login.username}', 20)),
              ),
              Container(
                decoration: BoxDecoration(
                    color: customblueColor(),
                    border: Border.all(width: 1, color: custombordercolor()),
                    borderRadius: BorderRadius.circular(4)),
                height: 40,
                width: 250,
                child: Center(child: subtitle('${login.email}', 16)),
              ),
              SizedBox(
                width: 250,
                child: Row(
                  children: [
                    subtitle('Edit Profile', 16),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => editprofilescreen(
                                  login: login,
                                  index: storedindex!,
                                  updateprofileinfo: updateprofileinfo)));
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 17,
                        ))
                  ],
                ),
              ),
              SizedBox(
                width: 250,
                child: Row(
                  children: [
                    subtitle('Wishlist', 16),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WishlistScreen()));
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: customblueColor(),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.only(
                      right: 50, left: 50, top: 5, bottom: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 2, color: custombordercolor())),
                ),
                onPressed: () {
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
                                    builder: (ctx1) => const loginScreen()),
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
                },
                child: subtitle('Logout', 15),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
