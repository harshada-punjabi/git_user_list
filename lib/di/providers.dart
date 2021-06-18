import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/data/remote/rest_service.dart';
import 'package:flutter_base_architecture/exception/base_error_handler.dart';
import 'package:git_users/data/repository/user_repository_impl.dart';
import 'package:git_users/datasource/datasources/user_datasource.dart';
import 'package:git_users/datasource/local/git_user_business_userstore.dart';
import 'package:git_users/datasource/remote/implementation/user_datasource_imp.dart';
import 'package:git_users/datasource/remote/providers/rest/request/user_request.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: GitUserStore()),
  Provider.value(value: UserListLandingErrorParser()),
  Provider(create: (_) => RESTService()),
];

List<SingleChildWidget> uiConsumableProviders = [];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<UserListLandingErrorParser,
      ErrorHandler<UserListLandingErrorParser>>(
    update: (context, errorParser, errorHandler) =>
        ErrorHandler<UserListLandingErrorParser>(errorParser),
  ),
  ProxyProvider<GitUserStore, UserStore<UserDomain>>(
    update: (
      context,
      localStore,
      userStore,
    ) =>
        localStore,
  ),
  ProxyProvider<RESTService, UserRequest>(
    update: (context, RESTService restService, UserRequest userRequest) =>
        UserRequest(restService),
  ),
  ProxyProvider<UserRequest, UserDataSource>(
    update: (context, userRequest, dataSource) =>
        UserDataSourceImpl(userRequest),
  ),
  ProxyProvider<UserDataSource, UserRepository>(
    update: (context, dataSource, repository) => UserRepositoryImpl(dataSource),
  ),
  ProxyProvider<UserRepository, GetUsersUseCase>(
    update:
        (context, UserRepository userRepo, GetUsersUseCase getUsersUseCase) =>
            GetUsersUseCase(userRepo),
  ),
];
