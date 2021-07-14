import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:git_users/domain/usecase/clear_box_usecase.dart';
import 'package:git_users/domain/usecase/delete_user_usecase.dart';
import 'package:git_users/domain/usecase/get_hive_users_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';

import 'package:git_users/presentation/model/user_item.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';

class SelectedListViewModel extends BaseViewModel {
  List<UserItem> _userList = <UserItem>[];
  GetHiveUsersUseCase getHiveUsersUseCase;
  DeleteUserUseCase deleteUserUseCase;
  DeleteAllUserUseCase deleteAllUserUseCase;

  List<UserItem> get userList => _userList;
  UserStore userStore;

  SelectedListViewModel(this.getHiveUsersUseCase, this.deleteUserUseCase, this.deleteAllUserUseCase);

  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }

 deleteUser(DeleteUserUseCaseParams params) async {
    final resp = await deleteUserUseCase.buildUseCaseFuture(params: params).catchError((error){
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
