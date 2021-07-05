import 'package:git_users/data/datasources/user_datasource.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/network.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource dataSource;


  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<UserDomain>> fetchUserList({int page}) async{

      return dataSource.getUsers(page: page);

  }

  @override
Future<List<UserDomain>> fetchHiveUser(){
    return dataSource.getUsersFromHive();
}
  @override
Future insertUsers(List<UserDomain> users){
    return dataSource.insertUsers(users);

}

}
