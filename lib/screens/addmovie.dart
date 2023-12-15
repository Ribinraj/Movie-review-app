// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/screens/admin_panel.dart';
import 'package:picture_pulse/widgets/database_functions.dart';
import 'package:picture_pulse/widgets/functions.dart';

class addmoviescreen extends StatefulWidget {
  final Function onMovieAdded;
  const addmoviescreen({super.key, required this.onMovieAdded});

  @override
  State<addmoviescreen> createState() => _addmoviescreenState();
}

class _addmoviescreenState extends State<addmoviescreen> {
  XFile? _image;
  final _movienameController = TextEditingController();
  final _moviedirectorController = TextEditingController();
  final _movielanguageController = TextEditingController();

  final _runtimeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _castController = TextEditingController();
  final _musicController = TextEditingController();
  final _videoController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  double _ratingValue = 0;
  String selectedGenre = 'Others';

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
            subtitle('Add movies to', 13),
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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 40, 228, 228),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _image != null
                      ? Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 50.0,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .45,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: custombordercolor()),
                                    color: customblueColor(),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      value: selectedGenre,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 9, 9, 9),
                                          fontSize: 18.0),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedGenre = newValue.toString();
                                        });
                                      },
                                      items: <String>[
                                        'Others',
                                        'Comedy',
                                        'Drama',
                                        'Thriller',
                                        'Action'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ))
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
                            Container(
                              height: MediaQuery.of(context).size.height * .075,
                              width: MediaQuery.of(context).size.width * .45,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: custombordercolor()),
                                  color: customblueColor(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: RatingBar(
                                  itemSize: 25,
                                  initialRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star,
                                        color: Colors.amber),
                                    half: const Icon(Icons.star_half,
                                        color: Colors.amber),
                                    empty: const Icon(Icons.star_border,
                                        color: Colors.amber),
                                  ),
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  onRatingUpdate: (rating) {
                                    _ratingValue = rating;
                                  },
                                ),
                              ),
                            )
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
                        maxLines: 4),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: loginSigninButton(
                          onPressed: () async {
                            saveMovieToDatabase();
                          },
                          buttonText: 'Submit'),
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
  void saveMovieToDatabase() {
    final key = DateTime.now().millisecondsSinceEpoch;
    if (_formkey.currentState!.validate()) {
      addMovietoDatabase(
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
            key: key.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        createCustomSnackBar(
          text: 'Data saved successfully',
          backgroundColor: Colors.green,
        ),
      );

      _movienameController.clear();
      _moviedirectorController.clear();
      _movielanguageController.clear();

      _runtimeController.clear();
      _descriptionController.clear();
      _castController.clear();
      _musicController.clear();
      setState(() {
        _image = null;
      });
    }
    widget.onMovieAdded();
    Navigator.of(context).pop();
  }
}
