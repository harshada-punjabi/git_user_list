import 'package:git_users/domain/model/user_domain.dart';
import 'maps_extensions.dart';

class UserEntity {
  final int id;
  final String login;

  UserEntity(
      {this.id,
      this.login,
      });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json.getOrElse('id', 0),
      login: json.getOrElse('login', ''),
    );
  }
}

extension UserEntityExtention on UserEntity {
  UserDomain mapToDomain() => UserDomain(
        id: id,
        login: login,
      );
}
extension UserListExtension on List<UserEntity> {
  List<UserDomain> mapToDomain() =>
      map((e) => e.mapToDomain()).toList();
}