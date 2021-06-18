import 'package:dio/src/response.dart';
import 'package:flutter_base_architecture/data/remote/response/rest_response.dart';
import 'package:flutter_base_architecture/exception/base_error.dart';
import 'package:git_users/datasource/remote/providers/rest/dto/git_user_landing_error_dto.dart';

abstract class GitUserLandingResponse<T> extends RESTResponse<T> {
  GitUserLandingResponse(Response response) : super(response);

  @override
  parseEncryptedResponse(dynamic encryptedResponse) {
    print("Response Encrypted:" + encryptedResponse.toString());
    parseResponse(encryptedResponse);
  }

  @override
  parseResponse(dynamic response) {
    if (super.response.statusCode != 200) {
      GitUserLandingErrorDto errorDto =
          GitUserLandingErrorDto.fromJson(response as Map<String, dynamic>);
      getErrors().add(BaseError(
        message: errorDto.errors?.first.toString(),
      ));
      return;
    }
    parseResponseData(super.response.data, super.apiIdenfier);
  }

  @override
  parseResponseData(dynamic dataArray, int apiIdentifier) {}
}
