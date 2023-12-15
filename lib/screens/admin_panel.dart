import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picture_pulse/screens/addmovie.dart';
import 'package:picture_pulse/screens/editingscreen.dart';
import 'package:picture_pulse/widgets/database_functions.dart';
import 'package:picture_pulse/widgets/functions.dart';

class AdminpanelScreen extends StatefulWidget {
  const AdminpanelScreen({super.key});

  @override
  State<AdminpanelScreen> createState() => _AdminpanelScreenState();
}

class _AdminpanelScreenState extends State<AdminpanelScreen> {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7),
              child: subtitle('Admin panel of', 13),
            ),
            titlelogo()
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
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
                    color: Colors.green,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: GetDataHome.movielistenable,
        builder: (context, value, child) => filteredMovie.isEmpty
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
                itemCount: filteredMovie.length,
                itemBuilder: (context, index) {
                  final movie = filteredMovie[index];

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
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.tealAccent),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: MediaQuery.of(context).size.width * .4,
                          height: MediaQuery.of(context).size.height * .15,
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
                        const SizedBox(
                          height: 5,
                        ),
                        subtitle('${movie.title}(${movie.language})', 15,
                            textColor: Colors.black),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  // ignore: avoid_types_as_parameter_names
                                  builder: (context) => AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                        "Are you sure want to delete"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Hive.box('addmovie').deleteAt(index);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            createCustomSnackBar(
                                                text: 'Deleted successfully',
                                                backgroundColor: Colors.red),
                                          );
                                          filtering();
                                        },
                                        child: const Text("Ok"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 114, 47, 42),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => editingScreen(
                                        movie: movie,
                                        index: index,
                                        onMovieAdded: () {
                                          filtering();
                                        })));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 44, 94, 46),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => addmoviescreen(onMovieAdded: () {
                    filtering();
                  })));
        },
        label: Row(
          children: [
            const Icon(Icons.add),
            const SizedBox(width: 8.0),
            subtitle('Addmovie', 19, textColor: Colors.black),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        backgroundColor: const Color.fromARGB(255, 33, 243, 240),
        elevation: 6.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
