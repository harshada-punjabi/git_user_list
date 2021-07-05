import 'package:git_users/domain/model/user_domain.dart';

import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends UserDomain{
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String login;

  @HiveField(2)
  final String avatar;

  User({this.id, this.login, this.avatar});
}