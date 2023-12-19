// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:picture_pulse/screens/movie_details.dart';
import 'package:picture_pulse/widgets/database_functions.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:picture_pulse/widgets/homepagefunctions.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();

  List filteredMovie = [];
  String selectedCategory = '';
  void filtering() {
    String search = searchController.text.toLowerCase();
    filteredMovie = GetDataHome.filterMovies(search, selectedCategory);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetDataHome.initializeDatabase();
    filteredMovie = List.from(GetDataHome.moviedataBox.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: titlelogo(),
        actions: [
          IconButton(
            icon: Icon(
              Mdi.menu,
              size: 27,
              color: custombordercolor(),
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(170),
            child: Container(
              color: const Color.fromARGB(255, 6, 6, 6),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 57,
                      child: TextField(
                        controller: searchController,
                        onChanged: (values) {
                          setState(() {
                            filtering();
                          });
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: custombordercolor(),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          labelText: "Search...",
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          fillColor: customblueColor(),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 251, 252, 251),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Categories',
                      style:
                          GoogleFonts.oswald(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          searchButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = '';
                                  filtering();
                                });
                              },
                              buttonText: 'All'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                setState(() {
                                  selectedCategory = 'Action';
                                  filtering();
                                });
                              },
                              buttonText: 'Action'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Comedy';
                                filtering();
                              },
                              buttonText: 'Comedy'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Thriller';
                                filtering();
                              },
                              buttonText: 'Thriller'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Drama';
                                filtering();
                              },
                              buttonText: 'Drama'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'English';
                                filtering();
                              },
                              buttonText: 'English'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Tamil';
                                filtering();
                              },
                              buttonText: 'Tamil'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Malayalam';
                                filtering();
                              },
                              buttonText: 'Malayalam'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Telungu';
                                filtering();
                              },
                              buttonText: 'Telungu'),
                          const SizedBox(
                            width: 10,
                          ),
                          searchButton(
                              onPressed: () {
                                selectedCategory = 'Hindi';
                                filtering();
                              },
                              buttonText: 'Hindi'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
      endDrawer: const MyDrawer(),
      body: ValueListenableBuilder(
        valueListenable: GetDataHome.movielistenable,
        builder: (context, value, child) => Container(
          padding: const EdgeInsets.all(10),
          color: const Color.fromARGB(255, 0, 0, 0),
          child: filteredMovie.isEmpty
              ? Center(
                  child: subtitle('No movies available', 20),
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: .8),
                  itemCount: filteredMovie.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = filteredMovie[index];
                    return GridTile(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: custombordercolor()),
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 8, 127, 140),
                          ),
                          child: Column(
                            children: [
                              const Padding(padding: EdgeInsets.all(5)),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.tealAccent),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.height * .125,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      File(
                                        movie.imageUrl.toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                onLongPress: () {
                                  {
                                    showFullScreenImageDialog(
                                        context, movie.imageUrl.toString());
                                  }
                                },
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetails(
                                            movie: movie,
                                          )));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 2, top: 5, bottom: 2),
                                child: Text(
                                  '${movie.title} | ${movie.language} | ${DateFormat("yyyy").format(movie.year)} |  ${movie.director} ',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(
                                          left: 2,
                                          right: 10,
                                          top: 2,
                                          bottom: 5)),
                                  customRatingBar(initialRating: movie.rating),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  FavoriteClass(
                                    index: index,
                                  )
                                ],
                              ),
                            ],
                          )),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
