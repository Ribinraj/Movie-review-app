import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/Model/login.dart';

// addmovie
addMovietoDatabase(Addmovie movie) {
  Hive.box('addMovie').add(movie);
}

// signup
signupTodatabase(Login signup) {
  Hive.box('login').add(signup);
}

// update
updateTodatabase(int index, Addmovie movie) {
  Hive.box('addMovie').putAt(index, movie);
}

//profileupdate
profileupdate(int index, Login login) {
  Hive.box('login').putAt(index, login);
}

// //homepagegeting

class GetDataHome {
  static late Box moviedataBox;
  static late ValueNotifier<List> movielistenable;
  static void initializeDatabase() {
    moviedataBox = Hive.box('addMovie');
    movielistenable = ValueNotifier(List.from(moviedataBox.values));
  }

  static List filterMovies(String search, String selectedCategory) {
    List filteredMovies = [];
    if (search.isNotEmpty) {
      filteredMovies = moviedataBox.values
          .where((film) =>
              film.title.toLowerCase().contains(search) ||
              film.language.toLowerCase().contains(search) ||
              film.year.toString().contains(search))
          .toList();
    } else {
      filteredMovies = selectedCategory.isEmpty
          ? List.from(moviedataBox.values)
          : moviedataBox.values
              .where((film) =>
                  film.genre.toLowerCase() == selectedCategory.toLowerCase() ||
                  film.language.toLowerCase() == selectedCategory.toLowerCase())
              .toList();
    }
    return filteredMovies;
  }
}
