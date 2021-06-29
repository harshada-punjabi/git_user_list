import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:git_users/domain/usecase/get_hive_users_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';

import 'package:git_users/presentation/model/user_item.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';

class SelectedListViewModel extends BaseViewModel{

List<UserItem> _userList = <UserItem>[];
GetHiveUsersUseCase getHiveUsersUseCase;
List<UserItem> get userList => _userList;
UserStore userStore;

SelectedListViewModel(this.getHiveUsersUseCase);

  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }

  Future<List<UserItem>> getUserList()async{
  }
getItem() async {
  setBusy(true);
  final List<UserItem> result =
  await getHiveUsersUseCase.buildUseCaseFuture().catchError((error) {
    print("error> ${error.toString()}");
    setBusy(false);
  }, test: (error) => error is UserListLandingError);
  setBusy(false);
  return result;

  // final box = await Hive.openBox<UserItem>(Strings.userBox);
  // _userList = box.values.toList();
  notifyListeners();
}
}