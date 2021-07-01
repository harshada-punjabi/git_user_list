import 'package:git_users/datasource/local/hive/user_model.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveRequest{
  HiveRequest(){
    _init();
  }
  Future<bool> _init() async{
//todo initialise the data
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      Hive.registerAdapter(UserAdapter());
      await Hive.openBox(Strings.userBox);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
  Future addUser(List<UserDomain> users) async{
    try {

      // return users hive box
      final usersBox = Hive.box(Strings.userBox);


      final converted = users
          .map((e) =>
          User(
              id: e.id,
              login: e.login,
              avatar: e.avatar))
          .toList();
      print('converted:::: $converted');

      // insert all users to hive box
      final entries = await usersBox.addAll(converted);
      print('added');
      print(entries);

    } on Exception catch (e) {
      print(e);

    }
  }
  Future getUsers() async{
    //todo get the users from hive database
    try{
      final box = Hive.box<User>(Strings.userBox);
      return box.values.map<User>((e) {
        return User(
          id: e.id,
          login: e.login,
          avatar: e.avatar,
        );
      }).toList();
    }on Exception catch (e){
      print(e);
    }
  }
  }

