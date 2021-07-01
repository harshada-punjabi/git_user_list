import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';

import 'package:git_users/domain/usecase/add_user_hive_usecase.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/model/user_item.dart';


class BaseListViewModel extends BaseViewModel {
  BaseListViewModel({this.getUsersUseCase,this.userListScrollController, this.addUsersUseCase,});
  List<UserItem> _userList = [];
  List<UserItem> _selectedUserList = [];

  List<UserItem> get selectedUserList => _selectedUserList;

  set selectedUserList(List<UserItem> value) {
    _selectedUserList = value;
    notifyListeners();
  }

  GetUsersUseCase getUsersUseCase;
  AddUsersUseCase addUsersUseCase;
  List<UserItem> get userList => _userList;
  ScrollController userListScrollController;
  int page = 0;
  bool notConnected = false;

  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }


  void refresh() {
    notifyListeners();
  }
  void selectCard(UserItem userItem,{AddHiveUsersUseCaseParams getHiveUsersUseCaseParams })async{
    _userList.firstWhere((element) => element.id == userItem.id)
        .setSelected(!userItem.isSelected);
    if(_userList.contains(userItem))
      _selectedUserList.add(userItem);
   getHiveUsersUseCaseParams.users = _selectedUserList;
   notifyListeners();
   await addUsersUseCase.buildUseCaseFuture(params: getHiveUsersUseCaseParams).catchError((error){
      print("error> ${error.toString()}");
    }, test: (error) => error is UserListLandingError);
    notifyListeners();
  }

  Future<dynamic> getUserList({GetUsersUseCaseParams params}) async {
    //if the data is loading
    setBusy(true);
    List<UserItem> result =
      await getUsersUseCase.buildUseCaseFuture(params: params).catchError((error) {
        print("error> ${error.toString()}");
        if(error.toString().toLowerCase().compareTo('Connection to API server failed due to internet connection'.toLowerCase())==0) {
        notConnected = true;
      }
      setBusy(false);
      }, test: (error) => error is UserListLandingError);
      if (result != null) {
        page = result.length;
        userList.addAll(result);
        print('length of the user list is as follows ${userList.length}');
    }
    // }else {
    //   SnackBar(content: Text('Offline mode', semanticsLabel: 'There is no internet connection'),);
    // }
    setBusy(false);
    // return result;
  }
  void onScroll(){
    userListScrollController.addListener(() async {
      if (userListScrollController.position.maxScrollExtent ==
          userListScrollController.position.pixels &&
          !busy) {
        setBusy(true);
        print('List End: Loading more user');
        await getUserList(params: GetUsersUseCaseParams(page))
            .then((response) {
          userList.addAll(response);
        });
        setBusy(false);
      }
    });
  }
}
