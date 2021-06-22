import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:git_users/datasource/local/model/user_model.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/model/user_item.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class BaseListViewModel extends BaseViewModel {
  BaseListViewModel( {this.getUsersUseCase,this.userListScrollController});
  List<UserItem> _userList = [];
  List<UserItem> _selectedUserList = [];

  List<UserItem> get selectedUserList => _selectedUserList;

  set selectedUserList(List<UserItem> value) {
    _selectedUserList = value;
    notifyListeners();
  }

  GetUsersUseCase getUsersUseCase;
  List<UserItem> get userList => _userList;
  ScrollController userListScrollController;
  int page = 0;

  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }
  String _userBox = 'user';

  addItem(UserItem user) async {
    var box = await Hive.openBox<UserItem>(_userBox);
    box.add(user);
    print('added');
    notifyListeners();
  }
  void refresh() {
    notifyListeners();
  }
  void selectCard(UserItem userItem,{BuildContext context}){
    _userList
        .firstWhere((element) => element.id == userItem.id)
        .setSelected(!userItem.isSelected);
    if(_userList.contains(userItem))
      _selectedUserList.add(userItem);
     addItem(UserItem(
      login: userItem.login,
      avtar: userItem.avtar,
    ));
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
    // _userList = [];
    if (result != null) {
      page = result.length;
      userList.addAll(result);
      print('length of the user list is as follows ${userList.length}');
    }
    setBusy(false);
    // return result;
  }
}
