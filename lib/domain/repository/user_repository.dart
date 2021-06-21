import 'package:git_users/domain/model/user_domain.dart';

abstract class UserRepository {
  Future<List<UserDomain>> fetchUserList({int page});
}
