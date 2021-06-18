import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/model/user_item.dart';

class UserListViewModel extends GitUserLandingBaseViewModel {
  //network call
  GetUsersUseCase _getUsersUseCase;

  UserListViewModel(this._getUsersUseCase);

  List<UserItem> _userList = [];
  final scrollController = ScrollController();
  final scrollThreshold = 200.0;

  List<UserItem> get userList => _userList;

  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }

  Future<void> getUserList() async {
    //if the data is loading
    setBusy(true);
    final List<UserItem> result =
        await _getUsersUseCase.buildUseCaseFuture().catchError((error) {
      print("error> ${error.toString()}");
      userList.clear();

      setBusy(false);
    }, test: (error) => error is UserListLandingError);
    _userList = [];
    if (result != null) {
      userList.addAll(result);
      print('length of the user list is as follows ${userList.length}');
    }
    setBusy(false);
    // return result;
  }
}
