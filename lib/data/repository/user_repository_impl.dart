import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/datasource/datasources/user_datasource.dart';
import 'package:git_users/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<UserDomain>> fetchUserList({int page}) {
    return dataSource.getUsers(page: page);
  }
}
