

import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';

abstract class UserRepository{
  Future<List<UserDomain>> fetchUserList();

}