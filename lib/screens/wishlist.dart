import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/Model/wishlist.dart';

import 'package:picture_pulse/widgets/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late Box wishlistBox;
  late Box addMovieBox;
  late int loggedInUserIndex = 0;

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box('wishlist');
    addMovieBox = Hive.box('addMovie');
    _loadLoggedInUserIndex();
  }

  Future<void> _loadLoggedInUserIndex() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    loggedInUserIndex = sharedpref.getInt('userIndex') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: subtitle('W i s h l i s t', 18),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: wishlistBox.listenable(),
        builder: (context, value, child) {
          List wishlistItems = wishlistBox.values
              .where((item) => item.userid == loggedInUserIndex)
              .toList();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .8,
            ),
            padding: const EdgeInsets.all(10),
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              Wishlist wishlistItem = wishlistItems[index];
              final movie = addMovieBox.getAt(wishlistItem.movieid) as Addmovie;

              return GridTile(
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: custombordercolor()),
                        borderRadius: BorderRadius.circular(10),
                        color: customblueColor()),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5, color: custombordercolor()),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: MediaQuery.of(context).size.width * .4,
                          height: MediaQuery.of(context).size.height * .15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                              File(movie.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        subtitle(movie.title, 15, textColor: Colors.black),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            customRatingBar(initialRating: movie.rating),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  int existingIndex = wishlistItems.indexWhere(
                                    (item) =>
                                        item.userid == loggedInUserIndex &&
                                        item.movieid == wishlistItem.movieid,
                                  );

                                  if (existingIndex != -1) {
                                    wishlistBox.deleteAt(existingIndex);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.favorite_sharp,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
