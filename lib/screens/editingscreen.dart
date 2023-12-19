// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/screens/admin_panel.dart';
import 'package:picture_pulse/widgets/add_editmovie.dart';

import 'package:picture_pulse/widgets/database_functions.dart';

import 'package:picture_pulse/widgets/functions.dart';

class editingScreen extends StatefulWidget {
  final Function onMovieAdded;
  final Addmovie movie;
  final int index;
  const editingScreen(
      {super.key,
      required this.movie,
      required this.index,
      required this.onMovieAdded});

  @override
  State<editingScreen> createState() => _addmoviescreenState();
}

class _addmoviescreenState extends State<editingScreen> {
  XFile? _image;
  final TextEditingController _movienameController = TextEditingController();
  late TextEditingController _moviedirectorController;
  late TextEditingController _movielanguageController;
  late TextEditingController _runtimeController;
  late TextEditingController _descriptionController;
  late TextEditingController _castController;
  late TextEditingController _musicController;
  final TextEditingController _videoController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late DateTime selectedDate;
  late double _ratingValue;
  late String selectedGenre;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  @override
  void initState() {
    super.initState();
    _movienameController.text = widget.movie.title;
    _videoController.text = widget.movie.videoId;
    _moviedirectorController =
        TextEditingController(text: widget.movie.director);
    _movielanguageController =
        TextEditingController(text: widget.movie.language);

    _runtimeController =
        TextEditingController(text: widget.movie.runtime.toString());
    _descriptionController =
        TextEditingController(text: widget.movie.description);
    _castController = TextEditingController(text: widget.movie.cast);
    _musicController = TextEditingController(text: widget.movie.music);

    selectedDate = DateFormat('yyyy-MM-dd').parse(widget.movie.year.toString());

    _image = XFile(widget.movie.imageUrl);
    _ratingValue = widget.movie.rating;
    selectedGenre = widget.movie.genre;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (context) => AdminpanelScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Row(
          children: [
            const Padding(padding: EdgeInsets.only(top: 200, left: 10)),
            Padding(
              padding: const EdgeInsets.only(top: 5, right: 3),
              child: subtitle('Edit movies', 13),
            ),
            titlelogo()
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              customImagePicker(image: _image, onTap: _pickImage),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subtitle('Movie name', 15),
                    textFormFieldWidget(
                      controller: _movienameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter movie name';
                        }
                        return null;
                      },
                      hintText: 'movie name',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Director', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                controller: _moviedirectorController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Director name';
                                  }
                                  return null;
                                },
                                hintText: 'Director name',
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Language', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                controller: _movielanguageController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter language';
                                  }
                                  return null;
                                },
                                hintText: 'movie language',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Year', 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width * .45,
                                        57),
                                    backgroundColor: customblueColor(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                            width: 2,
                                            color: custombordercolor())),
                                  ),
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    '$formattedDate',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Genre', 15),
                            customDropdown(
                              context: context,
                              value: selectedGenre,
                              items: [
                                'Others',
                                'Comedy',
                                'Drama',
                                'Thriller',
                                'Action'
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGenre = newValue.toString();
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Rating', 15),
                            CustomRatingBar(
                              initialValue: _ratingValue,
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _ratingValue = rating;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Runtime', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                controller: _runtimeController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter runtime';
                                  }
                                  return null;
                                },
                                hintText: 'enter runtime',
                                keyboardType: TextInputType.number,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Cast', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                controller: _castController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter casts';
                                  }
                                  return null;
                                },
                                hintText: 'Cast names',
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle('Music', 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .45,
                              child: textFormFieldWidget(
                                controller: _musicController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Music director';
                                  }
                                  return null;
                                },
                                hintText: 'Music director',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    subtitle('Trailer', 15),
                    textFormFieldWidget(
                      controller: _videoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Trailer';
                        }
                        return null;
                      },
                      hintText: 'Trailer Id',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    subtitle('Description', 15),
                    textFormFieldWidget(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter movie description';
                        }
                        return null;
                      },
                      hintText: 'movie description',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: loginSigninButton(
                          onPressed: () async {
                            updateMovieToDatabase();
                          },
                          buttonText: 'Update'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // functions
  void updateMovieToDatabase() {
    final Key = DateTime.now().millisecondsSinceEpoch;
    if (_formkey.currentState!.validate()) {
      updateTodatabase(
        widget.index,
        Addmovie(
            imageUrl: _image!.path,
            title: _movienameController.text,
            director: _moviedirectorController.text,
            language: _movielanguageController.text,
            year: selectedDate,
            genre: selectedGenre,
            rating: _ratingValue,
            runtime: double.tryParse(_runtimeController.text) ?? 0.0,
            cast: _castController.text,
            music: _musicController.text,
            description: _descriptionController.text,
            videoId: _videoController.text,
            key: Key.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        createCustomSnackBar(
          text: 'Data updated successfully',
          backgroundColor: Colors.green,
        ),
      );
    }
    widget.onMovieAdded();
    Navigator.of(context).pop();
  }
}
