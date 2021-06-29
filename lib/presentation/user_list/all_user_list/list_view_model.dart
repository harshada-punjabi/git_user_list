import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/domain/usecase/add_user_hive_usecase.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/model/user_item.dart';
import 'package:provider/provider.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';

class BaseListViewModel extends BaseViewModel {
  BaseListViewModel( {this.getUsersUseCase,this.userListScrollController, this.addUsersUseCase});
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

  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }


  void refresh() {
    notifyListeners();
  }
  void selectCard(UserItem userItem,{BuildContext context,
    GetHiveUsersUseCaseParams getHiveUsersUseCaseParams})async{

    _userList.firstWhere((element) => element.id == userItem.id)
        .setSelected(!userItem.isSelected);
    if(_userList.contains(userItem))
      _selectedUserList.add(userItem);
   getHiveUsersUseCaseParams.users = _selectedUserList;
   notifyListeners();
   await addUsersUseCase.buildUseCaseFuture(params: getHiveUsersUseCaseParams).catchError((error){
      print("error> ${error.toString()}");
    }, test: (error) => error is UserListLandingError);
    //todo add from the useCase or call the init db to initialize the db
     /*addItem(UserItem(
      login: userItem.login,
      avtar: userItem.avtar,
    ));*/
    notifyListeners();
  }

  Future<dynamic> getUserList({GetUsersUseCaseParams params}) async {
    //if the data is loading
    setBusy(true);
    final List<UserItem> result =
    await getUsersUseCase.buildUseCaseFuture(params: params).catchError((error) {
      print("error> ${error.toString()}");
      setBusy(false);
    }, test: (error) => error is UserListLandingError);
    if (result != null) {
      page = result.length;
      userList.addAll(result);
      print('length of the user list is as follows ${userList.length}');
    }
    setBusy(false);
    // return result;
  }
}
