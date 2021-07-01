import 'package:git_users/data/datasources/user_datasource.dart';
import 'package:git_users/datasource/local/hive/user_model.dart';
import 'package:git_users/datasource/remote/providers/rest/request/local/hive_request.dart';
import 'package:git_users/datasource/remote/providers/rest/request/user_request.dart';
import 'package:git_users/datasource/remote/providers/rest/response/user_response.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/datasource/entity/user_entity.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';


class UserDataSourceImpl extends UserDataSource {
  UserRequest _userRequest;
  HiveRequest _hiveRequest;

  UserDataSourceImpl(this._userRequest, this._hiveRequest);

  @override
  Future<List<UserDomain>> getUsers({int page}) async {
    try {
      var response = await _userRequest.getUsers(page: page);
      UserResponse userResponse = UserResponse(response);
      if (userResponse.getErrors().length != 0) {
        throw UserListLandingError(
            message: userResponse.getErrorString(),
            type: UserListLandingErrorType.SERVER_MESSAGE);
      } else {
        return userResponse.getData().mapToDomain();
      }
    } catch (exception) {
      throw UserListLandingError(
          message: exception.toString(),
          type: UserListLandingErrorType.SERVER_MESSAGE);
    }
  }

  @override
  Future<List<UserDomain>> getUsersFromHive() async {

    // return users hive box
    try{
 final response = await _hiveRequest.getUsers();
 UserResponse userResponse = UserResponse(response);
 if (userResponse.getErrors().length != 0) {
   throw UserListLandingError(
       message: userResponse.getErrorString(),
       type: UserListLandingErrorType.SERVER_MESSAGE);
 } else {
   return userResponse.getData().mapToDomain();
 }
    } catch (exception) {
      throw UserListLandingError(
          message: exception.toString(),
          type: UserListLandingErrorType.SERVER_MESSAGE);
    }

  }

  @override
  Future insertUsers(List<UserDomain> users) async {
    try {
      // return users hive box
      final response = await _hiveRequest.addUser(users);
      UserResponse userResponse = UserResponse(response);
      if (userResponse.getErrors().length != 0) {
        throw UserListLandingError(
            message: userResponse.getErrorString(),
            type: UserListLandingErrorType.SERVER_MESSAGE);
      } else {
         userResponse.getData().mapToDomain();

      }
    } on Exception catch (e) {
      print(e);

    }
  }
}



