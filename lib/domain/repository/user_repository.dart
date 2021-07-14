import 'package:git_users/domain/model/user_domain.dart';

abstract class UserRepository {
  Future<List<UserDomain>> fetchUserList({int page});
  Future<List<UserDomain>> fetchHiveUser();
  Future insertUsers(List<UserDomain> users);
  Future deleteUser(List<String> index);
 Future clearDataBase();
}
