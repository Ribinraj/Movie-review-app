// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picture_pulse/Model/login.dart';

import 'package:picture_pulse/widgets/database_functions.dart';
import 'package:picture_pulse/widgets/functions.dart';

class editprofilescreen extends StatefulWidget {
  final Login login;
  final int index;
  final Function(Login) updateprofileinfo;
  const editprofilescreen(
      {super.key,
      required this.login,
      required this.index,
      required this.updateprofileinfo});

  @override
  State<editprofilescreen> createState() => _editprofilescreenState();
}

class _editprofilescreenState extends State<editprofilescreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  XFile? _image;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.login.username;
    _emailController.text = widget.login.email;
    _passwordController.text = widget.login.password;

    _image =
        widget.login.imageUrl != null ? XFile(widget.login.imageUrl!) : null;
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: subtitle('e d i t  P r o f i l e', 20,
            textColor: customblueColor()),
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
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: custombordercolor(),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: custombordercolor())),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: _image != null
                        ? Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.camera_alt,
                            size: 50.0,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: 260,
                height: 50,
                child: textFormFieldWidget(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter movie name';
                    }
                    return null;
                  },
                  hintText: 'user name',
                ),
              ),
              SizedBox(
                width: 260,
                height: 50,
                child: textFormFieldWidget(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter movie name';
                    }
                    return null;
                  },
                  hintText: 'email',
                ),
              ),
              SizedBox(
                width: 260,
                height: 50,
                child: textFormFieldWidget(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter movie name';
                    }
                    return null;
                  },
                  hintText: 'password',
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
                    side: BorderSide(width: 2, color: custombordercolor()),
                  ),
                ),
                onPressed: () async {
                  updateProfile();
                },
                child: subtitle('update', 15),
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

  void updateProfile() {
    profileupdate(
      widget.index,
      Login(
        username: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        imageUrl: _image!.path,
      ),
    );
    widget.updateprofileinfo(Login(
      username: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      imageUrl: _image!.path,
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      createCustomSnackBar(
        text: 'Data updated successfully',
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }
}
