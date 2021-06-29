import 'package:git_users/domain/model/user_domain.dart';
import 'package:hive/hive.dart';

@HiveType()
class UserItem {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String login;
  @HiveField(2)
  final String avtar;
  bool isSelected;

  UserItem({
    this.id,
    this.login,
    this.avtar,
    this.isSelected = false
  });
  setSelected(bool value) {
    this.isSelected = value;
  }
  bool isTemporaryUser() => this.id == -1;
}

extension DomainToPresenationExt on UserDomain {
  UserItem mapToPresentation() => UserItem(
        id: this.id,
        login: this.login,
    avtar: this.avatar

      );
}
extension PresentationToDomain on UserItem {
  UserDomain mapToPDomain() => UserDomain(
      id: this.id,
      login: this.login,
      avatar: this.avtar

  );
}