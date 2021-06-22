import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:git_users/datasource/local/model/user_model.dart';
import 'package:git_users/presentation/model/user_item.dart';
import 'package:hive/hive.dart';

class SelectedListViewModel extends BaseViewModel{
//todo get the data from sharepreference
List<UserItem> _userList = <UserItem>[];

List<UserItem> get userList => _userList;
UserStore userStore;
String _userBox = 'user';


  set userList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }

  Future<List<UserItem>> getUserList()async{
  }
getItem() async {
  final box = await Hive.openBox<UserItem>(_userBox);
  _userList = box.values.toList();
  notifyListeners();
}
}