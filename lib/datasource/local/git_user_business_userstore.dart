import 'dart:async';
import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:git_users/domain/model/user_domain.dart';
import 'package:git_users/presentation/model/user_item.dart';

class GitUserStore extends UserStore<UserDomain> {
  StreamController<UserItem> _userController = StreamController<UserItem>();

  Stream<UserItem> get userStream => _userController.stream;

  userStore() {
    init();
  }

  @override
  Future<bool> setUser(UserDomain userDto) {
    _userController.sink.add(userDto.mapToPresentation());
    return super.setUser(userDto);
  }

  @override
  UserDomain mapUserDto(decode) {
    print("UserDto> $decode");
    UserDomain user = UserDomain.fromJson(decode);
    _userController.sink.add(user.mapToPresentation());
    return user;
  }

  Future<void> init() async {
    UserDomain user = await getLoggedInUserJson();
    _userController.sink.add(user?.mapToPresentation());
  }

  Future<bool> forceLogoutUser() async {
    await removeUser();
    // _userSessionExpired.add(true);
    return true;
  }
}
