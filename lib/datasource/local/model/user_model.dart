import 'package:git_users/presentation/model/user_item.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType()
class User{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String login;

  @HiveField(2)
  final String avatar;

  User({this.id, this.login, this.avatar});
}