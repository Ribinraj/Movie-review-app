import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:intl/intl.dart';
import 'package:picture_pulse/Model/addMovie.dart';
import 'package:picture_pulse/screens/commendSceen.dart';

import 'package:picture_pulse/widgets/functions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  final Addmovie movie;
  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: titlelogo(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            subtitle('Details', 20),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: const Color.fromARGB(255, 63, 223, 207)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                      initialVideoId: widget.movie.videoId,
                      flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      )),
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${widget.movie.title}(${widget.movie.language})',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: customblueColor(),
                border: Border.all(
                    width: 2, color: const Color.fromARGB(255, 125, 233, 237)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customRatingBar(initialRating: widget.movie.rating),
                  const VerticalDivider(
                    thickness: 2,
                    color: Color.fromARGB(255, 68, 239, 255),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Mdi.clockOutline,
                      ),
                      Text(
                        '${widget.movie.runtime} Hour',
                      )
                    ],
                  ),
                  const VerticalDivider(
                    thickness: 2,
                    color: Color.fromARGB(255, 68, 239, 255),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommendScreen(
                          movie: widget.movie,
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: customblueColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Comments',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  color: customblueColor(),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 79, 240, 227))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subtitle('Director : ${widget.movie.director}', 15,
                          textColor: Colors.black),
                      subtitle(
                          'Year : ${DateFormat('yyyy-MMM-dd').format(widget.movie.year)}',
                          15,
                          textColor: Colors.black),
                      subtitle('Language : ${widget.movie.language}', 15,
                          textColor: Colors.black),
                      subtitle('Music : ${widget.movie.music}', 15,
                          textColor: Colors.black),
                      subtitle('Cast : ${widget.movie.cast}', 15,
                          textColor: Colors.black),
                      subtitle('Genre : ${widget.movie.genre}', 15,
                          textColor: Colors.black)
                    ]),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            subtitle('A cinematic journey through....', 20,
                textColor: Colors.red),
            Text(
              widget.movie.description,
              style: const TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
            )
          ]),
        ),
      ),
    );
  }
}
