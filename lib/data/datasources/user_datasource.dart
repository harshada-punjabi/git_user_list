import 'package:git_users/domain/model/user_domain.dart';

abstract class UserDataSource {
  Future<List<UserDomain>> getUsers({int page});
  Future<List<UserDomain>> getUsersFromHive();
  Future insertUsers(List<UserDomain> users);
}
