//image picker
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:picture_pulse/widgets/functions.dart';

Widget customImagePicker({
  required XFile? image,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: customblueColor(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: image != null
          ? Image.file(
              File(image.path),
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
  );
}

//dropdown
Widget customDropdown({
  required BuildContext context,
  required String value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * .45,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: custombordercolor()),
        color: customblueColor(),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
              color: Color.fromARGB(255, 9, 9, 9), fontSize: 18.0),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
//ratingbar

class CustomRatingBar extends StatelessWidget {
  final double initialValue;
  final Function(double) onRatingUpdate;

  const CustomRatingBar({
    Key? key,
    required this.initialValue,
    required this.onRatingUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.075,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: customblueColor(),
        border: Border.all(width: 2, color: custombordercolor()),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: RatingBar(
          itemSize: 25,
          initialRating: initialValue,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: const Icon(Icons.star, color: Colors.amber),
            half: const Icon(Icons.star_half, color: Colors.amber),
            empty: const Icon(Icons.star_border, color: Colors.amber),
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          onRatingUpdate: onRatingUpdate,
        ),
      ),
    );
  }
}
