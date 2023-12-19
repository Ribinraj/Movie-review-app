import 'package:flutter/material.dart';
import 'package:picture_pulse/widgets/functions.dart';

class Aboutscreeen extends StatelessWidget {
  const Aboutscreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, bottom: 15, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customtext('About Picture Pulse', 25),
              customtext(
                  '''Welcome to Picture Pulse, your go-to destination for all things movies! Picture Pulse is a cutting-edge movie reviewing app that brings the magic of cinema right to your fingertips. Immerse yourself in the world of film, share your thoughts, and discover new favorites with our user-friendly platform.''',
                  15),
              customtext('Key Features:', 25),
              const SizedBox(
                height: 10,
              ),
              customtext('Favorite Movies:', 20),
              customtext(
                  '''◉ Save and organize your favorite movies in one place.
◉ Easily access your go-to films for a quick movie night.''', 15),
              customtext('User Comments:', 20),
              customtext(
                  '''◉ Engage with the movie-loving community by adding your comments and thoughts.
◉ Read and respond to comments from fellow cinephiles.''', 15),
              customtext('Profile Customization:', 20),
              customtext(
                  '''◉ Personalize your profile with a unique avatar and details.
◉ Showcase your favorite genres and share your movie-watching preferences.''',
                  15),
              customtext('Movie Management:', 20),
              customtext('◉Admin Panel:', 20),
              customtext('''◉ Admins can effortlessly add new movies to the app.
◉ Update movie details and trailers to keep the content fresh.''', 15),
              customtext('◉Content Control:', 20),
              customtext(
                  '''◉Ensure quality content by editing or removing movies as needed.''',
                  15),
              customtext('Meet the Developer:', 20),
              SizedBox(
                height: 10,
              ),
              customtext('Ribinraj Op', 20),
              customtext(
                  'Passionate about technology and cinema, Ribinraj Op is the creative mind behind Picture Pulse. With a vision to make movie reviewing a seamless experience, Ribinraj brings innovation and enthusiasm to the app development landscape.',
                  15),
              customtext('Contact Ribinraj Op:', 20),
              customtext('''Email: ribinrajop@gmail.com
Picture Pulse is more than just a movie app; it's a community of movie enthusiasts coming together to celebrate the art of storytelling through film. Join us on this cinematic journey, and let Picture Pulse be your guide to a world of endless movie magic.''',
                  15)
            ],
          ),
        ),
      ),
    );
  }
}
