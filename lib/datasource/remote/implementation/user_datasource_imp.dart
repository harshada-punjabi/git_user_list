import 'package:git_users/datasource/datasources/user_datasource.dart';
import 'package:git_users/datasource/remote/providers/rest/request/user_request.dart';
import 'package:git_users/datasource/remote/providers/rest/response/user_response.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/datasource/entity/user_entity.dart';

class UserDataSourceImpl extends UserDataSource {
  UserRequest _userRequest;

  UserDataSourceImpl(this._userRequest);

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
}
