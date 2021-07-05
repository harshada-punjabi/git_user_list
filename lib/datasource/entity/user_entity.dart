import 'package:git_users/domain/model/user_domain.dart';
import 'maps_extensions.dart';

class UserEntity {
  final int id;
  final String login;
  final String avatar;

  UserEntity({
    this.id,
    this.login,
    this.avatar
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json.getOrElse('id', 0),
      login: json.getOrElse('login', ''),
      avatar: json.getOrElse('avatar_url', '')
    );
  }
}

extension UserEntityExtention on UserEntity {
  UserDomain mapToDomain() => UserDomain(
        id: id,
        login: login,
    avatar: avatar
      );
}

extension UserListExtension on List<UserEntity> {
  List<UserDomain> mapToDomain() => map((e) => e.mapToDomain()).toList();
}
