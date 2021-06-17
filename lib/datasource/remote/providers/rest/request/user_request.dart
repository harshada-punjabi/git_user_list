
import 'package:flutter_base_architecture/data/remote/rest_service.dart';
import 'package:git_users/datasource/remote/providers/rest/request/git_user_landing_request.dart';

import '../api_identifiers.dart';
import '../end_points.dart';

class UserRequest extends GitUserLandingRestRequest{
  UserRequest(RESTService service) : super(service);

  Future getUsers() async {
    Map<String, dynamic> params = Map();
    params.putIfAbsent("since", () {
      return 31;
    });
    print('the end point${Endpoint.USERS}');
    return await execute(Endpoint.USERS.toString(), params,
        RESTService.GET, ApiIdentifier.API_USER_LIST,forceRefresh: true);
  }


}