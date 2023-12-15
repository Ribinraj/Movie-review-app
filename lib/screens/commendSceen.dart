import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/Model/commend.dart';
import 'package:picture_pulse/Model/login.dart';
import 'package:picture_pulse/widgets/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommendScreen extends StatefulWidget {
  final Addmovie movie;
  const CommendScreen({super.key, required this.movie});

  @override
  State<CommendScreen> createState() => _CommendScreenState();
}

class _CommendScreenState extends State<CommendScreen> {
  late int userIndex;
  late Box commendDataBox;
  late Box userDataBox;
  List<Commend> filteredComments = [];
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    commendDataBox = Hive.box('commend');
    userDataBox = Hive.box('login');
    getIndexfromSharedpref();
    filterCommentsByMovieKey();
  }

  Future<void> getIndexfromSharedpref() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    setState(() {
      userIndex = sharedpref.getInt('userIndex') ?? 0;
    });
  }

  void filterCommentsByMovieKey() {
    List allComments = commendDataBox.values.toList();
    filteredComments = List<Commend>.from(
        allComments.where((comment) => comment.moviekey == widget.movie.key));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: subtitle('C o m m e n t s', 20, textColor: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredComments.length,
              itemBuilder: (context, index) {
                Commend comment = filteredComments[index];
                Login user = userDataBox.get(comment.userid) as Login;
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 215, 207, 207),
                        borderRadius: BorderRadius.circular(100),
                        border:
                            Border.all(width: 1, color: custombordercolor())),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: user.imageUrl != null
                          ? Image.file(
                              File(user.imageUrl.toString()),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.person,
                              size: 50.0,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  title: subtitle(user.username, 15),
                  subtitle: Text(
                    comment.commend,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 192, 181, 181)),
                  ),
                  trailing: Text(
                    DateFormat('yyyy-MMM-dd').format(comment.date),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        fillColor: Color.fromARGB(255, 214, 197, 197),
                        filled: true),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      Hive.box('commend').add(Commend(
                          userid: userIndex,
                          moviekey: widget.movie.key,
                          commend: commentController.text,
                          date: DateTime.now()));
                      setState(() {
                        commentController.clear();
                        filterCommentsByMovieKey();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
