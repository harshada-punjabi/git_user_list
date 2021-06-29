// import 'package:git_users/data/datasources/local/user_local_datasource.dart';
// import 'package:git_users/domain/model/user_domain.dart';
// import 'package:git_users/domain/repository/hive_repository.dart';
//
// class HiveRepositoryImpl extends HiveRepository {
//   final HiveDataSource dataSource;
//
//   HiveRepositoryImpl(this.dataSource);
//
//   @override
//   Future<bool> addUser(List<UserDomain> users) {
//     return dataSource.insertUsers(users);
//   }
//
//   @override
//   Future<List<UserDomain>> fetchHiveUserList() {
//     return dataSource.getUsersFromHive();
//   }
// }
