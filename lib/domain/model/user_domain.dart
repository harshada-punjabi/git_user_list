import 'package:flutter_base_architecture/dto/base_dto.dart';
import 'package:git_users/presentation/model/user_item.dart';


class UserDomain extends BaseDto {
  int id = -1;
  String login;


  UserDomain({
    this.id: -1,
    this.login,

  });

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["login"] = login;
    return map;
  }

  UserDomain.fromJson(Map<String, dynamic> objects) {
    id = objects["id"];
    login = objects["login"];

  }
}

extension UserExtention on UserDomain {
  UserItem mapToUserPresentation() =>
      UserItem(
        id: this.id,
        login: this.login,

      );
}
extension UserListExtension on List<UserDomain> {
  List<UserItem> mapToUserListItem() =>
      map((e) => e.mapToUserPresentation()).toList();
}
