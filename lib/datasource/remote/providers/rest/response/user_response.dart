

import 'package:dio/src/response.dart';
import 'package:git_users/datasource/entity/user_entity.dart';
import 'package:git_users/datasource/remote/providers/rest/response/git_user_landing_response.dart';
import 'package:git_users/datasource/entity/maps_extensions.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import '../api_identifiers.dart';

class UserResponse extends GitUserLandingResponse<UserEntity> {
  UserResponse(Response response) : super(response);


  @override
  parseResponseData(data, int apiIdentifier) {

    switch (apiIdentifier) {
      case ApiIdentifier.API_USER_LIST:
        try {
          var responseData = data as Map<String, dynamic>;
          // var list = responseData.getOrElse("results", List()) as List<dynamic>;
          var list = responseData.getOrElse("", List()) as List<dynamic>;
          List<UserEntity> userListEntity = list.map((json) {
            return UserEntity.fromJson(json);
          }).toList();
          getData().addAll(userListEntity);
        }
        catch (exception) {
          getErrors().add(UserListLandingError(
              message: exception.toString(),
              type: UserListLandingErrorType.INVALID_RESPONSE));
        }
        break;
    }
  }
}