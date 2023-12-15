import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'addMovie.g.dart';

@HiveType(typeId: 0)
class Addmovie extends HiveObject {
  @HiveField(0)
  final String imageUrl;
  @HiveField(1)
  final String title;

  @HiveField(2)
  final String director;

  @HiveField(3)
  final String language;
  @HiveField(4)
  final DateTime year;
  @HiveField(5)
  final String genre;
  @HiveField(6)
  final double rating;
  @HiveField(7)
  final double runtime;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final String cast;

  @HiveField(10)
  final String music;
  @HiveField(11)
  final String videoId;
  @override
  @HiveField(12)
  final String key;

  Addmovie(
      {required this.imageUrl,
      required this.title,
      required this.director,
      required this.language,
      required this.year,
      required this.genre,
      required this.rating,
      required this.runtime,
      required this.description,
      required this.cast,
      required this.music,
      required this.videoId,
      required this.key});
}
