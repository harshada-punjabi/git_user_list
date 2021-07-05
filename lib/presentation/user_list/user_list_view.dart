
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/responsive/orientation_layout.dart';
import 'package:flutter_base_architecture/responsive/screen_type_layout.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/user_list/user_list_view_mobile.dart';
import 'package:git_users/presentation/user_list/user_list_view_model.dart';


class UserListView extends GitUserBaseView<UserListViewModel> {
  UserListView();

  @override
  UserListViewState createState() => UserListViewState();
}

class UserListViewState
    extends UserListViewBaseState<UserListViewModel, UserListView> {


  UserListViewState() {
    setRequiresLogin(false);
  }

  @override
  Widget buildBody() {
    return ScreenTypeLayout(
      mobile: OrientationLayoutBuilder(
        portrait: (context) =>
        UserListViewMobile()
      ),
    );
  }

   @override
  PreferredSizeWidget buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: Text('Git Use List'),
      bottom: TabBar(
        tabs: [
          Tab(text: 'All User',),
          Tab(text: 'Selected User',),
        ],
      ),
    );
  }


  @override
  void onModelReady(UserListViewModel model) async {
    //widget is created


    print('initState userListScreen');
  }

  @override
  UserListViewModel initViewModel() {
    return UserListViewModel();
  }

  @override
  Color statusBarColor() {
    return Color(0xFF181822);
  }
}
