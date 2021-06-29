import 'package:git_users/domain/model/user_domain.dart';

abstract class HiveDataSource {

  Future<bool> insertUsers(List<UserDomain> users);
  Future<List<UserDomain>> getUsersFromHive();
}