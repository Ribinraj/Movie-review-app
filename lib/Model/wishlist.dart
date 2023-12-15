import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'wishlist.g.dart';

@HiveType(typeId: 2)
class Wishlist extends HiveObject {
  @HiveField(0)
  final int userid;
  @HiveField(1)
  final int movieid;

  Wishlist({
    required this.userid,
    required this.movieid,
  });
}
