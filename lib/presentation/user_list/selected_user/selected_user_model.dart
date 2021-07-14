import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:git_users/datasource/local/hive/user_model.dart';
import 'package:git_users/domain/usecase/clear_box_usecase.dart';
import 'package:git_users/domain/usecase/delete_user_usecase.dart';
import 'package:git_users/domain/usecase/get_hive_users_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';

import 'package:git_users/presentation/model/user_item.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';

class SelectedListViewModel extends BaseViewModel {
  List<User> _userList = <User>[];
  GetHiveUsersUseCase getHiveUsersUseCase;
  DeleteUserUseCase deleteUserUseCase;
  DeleteAllUserUseCase deleteAllUserUseCase;
  List<String> userIds =[];
  List<User> _selectedUserList = [];
  bool selectionModeOn = false;
  List<User> get userList => _userList;
  UserStore userStore;
   final userBox = Hive.box(Strings.userBox);

  SelectedListViewModel(this.getHiveUsersUseCase, this.deleteUserUseCase, this.deleteAllUserUseCase);

  set userList(List<User> value) {
    _userList = value;
    notifyListeners();
  }
  bool returnAvailable(int index) {
    bool flag = false;
    for (int i = 0; i < _selectedUserList.length; i++) {
      if (_selectedUserList[i].isSelected) {
        selectionModeOn = true;
        print('selectionMode on ::: $selectionModeOn');
        return selectionModeOn;
      }
    }
    return flag;
  }
  void selectCard(User userItem)async{
    userBox.values.firstWhere((element) => element.id == userItem.id)
        .setSelected(!userItem.isSelected);
    if(userBox.values.contains(userItem))
      userIds.add(userItem.id.toString());
      _selectedUserList.add(userItem);
    notifyListeners();
  }
 deleteUser(List<String> index) async {
    print('index is ${index.length} and ${index.first}');
    final resp = await deleteUserUseCase.buildUseCaseFuture(params: DeleteUserUseCaseParams(index)).catchError((error){
      print("error>>> ${error.toString()}");
    }, test: (error) => error is UserListLandingError
    );
    notifyListeners();
    return resp;

}
  getItem() async {
    setBusy(true);
    final List<UserItem> result =
        await getHiveUsersUseCase.buildUseCaseFuture().catchError((error) {
      print("error>>> ${error.toString()}");
      setBusy(false);
    }, test: (error) => error is UserListLandingError);
    setBusy(false);
    return result;
  }
  deleteAllUser() async {
    final resp = await deleteAllUserUseCase.buildUseCaseFuture().catchError((error){
      print("error>>> ${error.toString()}");
    }, test: (error) => error is UserListLandingError
    );
    notifyListeners();
    return resp;
  }
}
