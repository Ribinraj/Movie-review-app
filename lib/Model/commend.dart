import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'commend.g.dart';

@HiveType(typeId: 3)
class Commend extends HiveObject {
  @HiveField(0)
  final int userid;
  @HiveField(1)
  final String moviekey;
  @HiveField(2)
  final String commend;
  @HiveField(3)
  final DateTime date;

  Commend(
      {required this.userid,
      required this.moviekey,
      required this.commend,
      required this.date});
}
