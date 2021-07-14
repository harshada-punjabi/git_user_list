import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/data/remote/rest_service.dart';
import 'package:flutter_base_architecture/exception/base_error_handler.dart';

import 'package:git_users/data/datasources/user_datasource.dart';
import 'package:git_users/data/repository/user_repository_impl.dart';
import 'package:git_users/datasource/local/git_user_business_userstore.dart';

import 'package:git_users/datasource/remote/implementation/user_datasource_imp.dart';
import 'package:git_users/datasource/remote/providers/rest/request/local/hive_request.dart';
import 'package:git_users/datasource/remote/providers/rest/request/user_request.dart';
import 'package:git_users/domain/model/user_domain.dart';

import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/domain/usecase/add_user_hive_usecase.dart';
import 'package:git_users/domain/usecase/clear_box_usecase.dart';
import 'package:git_users/domain/usecase/delete_user_usecase.dart';
import 'package:git_users/domain/usecase/get_hive_users_usecase.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/model/user_item.dart';
import 'package:git_users/presentation/user_list/all_user_list/list_view_model.dart';
import 'package:git_users/presentation/user_list/selected_user/selected_user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../network.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider(create:(_) => GitUserStore()),
  Provider(create:(_) => UserListLandingErrorParser()),
  Provider(create: (_) => RESTService()),
  Provider(create: (_) => HiveRequest()),
  Provider(create: (_) => DataConnectionChecker()),

];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<UserItem>(
    initialData: UserItem(),
    create: (context) =>
    Provider.of<GitUserStore>(context, listen: false).userStream,
  ),

];
List<SingleChildWidget> dependentServices = [

  ProxyProvider<UserListLandingErrorParser,
      ErrorHandler<UserListLandingErrorParser>>(
    update: (context, errorParser, errorHandler) =>
        ErrorHandler<UserListLandingErrorParser>(errorParser),
  ),

  ProxyProvider<DataConnectionChecker, NetworkInfo>(
    update: (context, data,network) => NetworkInfoImpl(data),
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

  ProxyProvider3<UserRequest, HiveRequest,NetworkInfo, UserDataSource>(
    update: (context, userRequest, hiveRequest,network, dataSource) =>
        UserDataSourceImpl(userRequest, hiveRequest, network),
  ),
  ProxyProvider<UserDataSource, UserRepository>(
    update: (context, dataSource, repository) => UserRepositoryImpl(dataSource),
  ),
  ProxyProvider<UserRepository, GetUsersUseCase>(
    update:
        (context, UserRepository userRepo, GetUsersUseCase getUsersUseCase) =>
            GetUsersUseCase(userRepo),
  ),
  ProxyProvider<UserRepository, GetHiveUsersUseCase>(
    update:
        (context, UserRepository userRepo, GetHiveUsersUseCase getHiveUsersUseCase) =>
            GetHiveUsersUseCase(userRepo),
  ),
  ProxyProvider<UserRepository, AddUsersUseCase>(
    update:
        (context, UserRepository userRepo, AddUsersUseCase addUserUsecase) =>
            AddUsersUseCase(userRepo),
  ),
  ProxyProvider<UserRepository, DeleteUserUseCase>(
    update:
        (context, UserRepository userRepo, DeleteUserUseCase deleteUseCase) =>
            DeleteUserUseCase(userRepo),
  ),
  ProxyProvider<UserRepository, DeleteAllUserUseCase>(
    update:
        (context, UserRepository userRepo, DeleteAllUserUseCase deleteUseCase) =>
            DeleteAllUserUseCase(userRepo),
  ),
  ProxyProvider3<GetHiveUsersUseCase,DeleteUserUseCase,DeleteAllUserUseCase, SelectedListViewModel>(
    update: (context, GetHiveUsersUseCase usecase, DeleteUserUseCase deleteUserUseCase,DeleteAllUserUseCase deleteAllUseCase,SelectedListViewModel viewModel )=>
    SelectedListViewModel(usecase, deleteUserUseCase,deleteAllUseCase),
    
  ),

  ChangeNotifierProvider<BaseListViewModel>(
      create:
          (context) =>
              BaseListViewModel(userListScrollController: ScrollController())),
  ChangeNotifierProvider<SelectedListViewModel>(
      create:
          (context) =>
              SelectedListViewModel(Provider.of(context),Provider.of(context), Provider.of(context))),

];
