import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'login.g.dart';

@HiveType(typeId: 1)
class Login extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String? imageUrl;

  Login(
      {required this.username,
      required this.email,
      required this.password,
      this.imageUrl});
}
