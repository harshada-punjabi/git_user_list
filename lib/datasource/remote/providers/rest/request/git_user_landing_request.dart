import 'package:dio/dio.dart';
import 'package:flutter_base_architecture/data/remote/request/rest_request.dart';
import 'package:flutter_base_architecture/data/remote/rest_service.dart';


abstract class GitUserLandingRestRequest extends RESTRequest {
  RESTService service;
 static const int page = 1;

  GitUserLandingRestRequest(this.service,
      {apiUrl = 'https://api.github.com',
        schema: "http",
        host: "api.github.com"}
      )
      : super(
    service,
    apiUrl: apiUrl,
    schema: schema,
    host: host,
  ) {
    this.service = service;
  }

  @override
  Future<Response> execute(dynamic endpoint, Map<String, dynamic> params,
      int apiCallMethod, int apiIdentifier,
      {forceRefresh: false}) async {
    return await super
        .execute(endpoint, params, apiCallMethod, apiIdentifier,
        forceRefresh: forceRefresh)
        .then((value) => value, onError: (e) {});
  }
}
