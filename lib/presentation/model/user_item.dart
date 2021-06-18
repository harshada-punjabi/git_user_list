import 'package:git_users/domain/model/user_domain.dart';

class UserItem {
  final int id;
  final String login;

  UserItem({
    this.id,
    this.login,
  });

  bool isTemporaryUser() => this.id == -1;
}

extension DomainToPresenationExt on UserDomain {
  UserItem mapToPresentation() => UserItem(
        id: this.id,
        login: this.login,
      );
}
