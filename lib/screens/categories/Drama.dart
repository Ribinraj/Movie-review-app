// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/screens/home.dart';
import 'package:picture_pulse/screens/movie_details.dart';
import 'package:picture_pulse/widgets/functions.dart';

class dramaScreen extends StatefulWidget {
  const dramaScreen({super.key});

  @override
  State<dramaScreen> createState() => _dramaScreenState();
}

class _dramaScreenState extends State<dramaScreen> {
  List<Addmovie> dramaMovies = [];
  void getDramaMovies() {
    final box = Hive.box('addMovie');
    final movies = box.values.toList();
    for (final movie in movies) {
      if (movie.genre == 'Drama') {
        dramaMovies.add(movie);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getDramaMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const homeScreen(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: subtitle('Drama movies', 20),
        centerTitle: true,
      ),
      body: dramaMovies.isEmpty
          ? Center(
              child: subtitle('No movies available', 20),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: .8),
              padding: const EdgeInsets.all(10),
              itemCount: dramaMovies.length,
              itemBuilder: (context, index) {
                final movie = dramaMovies[index];
                return GridTile(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 97, 246, 226)),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 22, 164, 180)),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: MediaQuery.of(context).size.width * .4,
                          height: MediaQuery.of(context).size.height * .18,
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetails(movie: movie)));
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      subtitle('${movie.title}(${movie.language})', 15,
                          textColor: Colors.black),
                      const SizedBox(
                        height: 10,
                      ),
                      customRatingBar(initialRating: movie.rating),
                    ],
                  ),
                ));
              },
            ),
    );
  }
}
