// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// titlelogo
Widget titlelogo() {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
            text: 'picture',
            style: GoogleFonts.play(
              color: Color.fromARGB(255, 47, 233, 221),
              fontStyle: FontStyle.italic,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            )),
        TextSpan(
          text: 'P',
          style: GoogleFonts.play(
            color: Color.fromARGB(255, 213, 3, 3),
            fontStyle: FontStyle.italic,
            fontSize: 40,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextSpan(
          text: 'ulse',
          style: GoogleFonts.play(
            color: Color.fromARGB(255, 213, 3, 3),
            fontStyle: FontStyle.italic,
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// textfield title
Widget subtitle(String text, double fontSize,
    {Color textColor = const Color.fromARGB(255, 255, 255, 255)}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.notoSerif(
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    ),
  );
}

//text
Widget customtext(String text, double fontSize,
    {Color textColor = const Color.fromARGB(255, 255, 255, 255)}) {
  return Text(
    text,
    style: TextStyle(
      color: textColor,
      fontSize: fontSize,
    ),
  );
}

// textformfield
Widget textFormFieldWidget(
    {required TextEditingController controller,
    required String? Function(String?)? validator,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: custombordercolor(),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.white),
      ),
      fillColor: customblueColor(),
      filled: true,
      hintText: hintText,
    ),
    keyboardType: keyboardType,
    obscureText: obscureText,
    maxLines: maxLines,
  );
}

// button
Widget loginSigninButton({
  required VoidCallback onPressed,
  required String buttonText,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: EdgeInsets.only(right: 50, left: 50, top: 5, bottom: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Text(
      buttonText,
      style: GoogleFonts.oswald(
        fontSize: 23,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// snakbar
SnackBar createCustomSnackBar(
    {required String text, required Color backgroundColor}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    content: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
// ratingbar

Widget customRatingBar({double itemSize = 16, double initialRating = 0.0}) {
  return RatingBar(
    itemSize: itemSize,
    initialRating: initialRating,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    ratingWidget: RatingWidget(
      full: const Icon(Icons.star, color: Colors.amber),
      half: const Icon(Icons.star_half, color: Colors.amber),
      empty: const Icon(Icons.star_border, color: Colors.amber),
    ),
    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
    ignoreGestures: true,
    onRatingUpdate: (rating) {},
  );
}

// color
Color customblueColor() {
  return Color.fromARGB(255, 8, 127, 140);
}

Color custombordercolor() {
  return Color.fromARGB(255, 68, 255, 239);
}

//gradient
BoxDecoration getGradientDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: const [
        Color.fromARGB(255, 2, 79, 86),
        Color.fromARGB(255, 4, 4, 4),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
