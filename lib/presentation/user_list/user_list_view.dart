
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/responsive/orientation_layout.dart';
import 'package:flutter_base_architecture/responsive/screen_type_layout.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/user_list/user_list_view_mobile.dart';
import 'package:git_users/presentation/user_list/user_list_view_model.dart';
import 'package:provider/provider.dart';

class UserListView extends GitUserBaseView<UserListViewModel> {
  UserListView();

  @override
  UserListViewState createState() => UserListViewState();
}

class UserListViewState
    extends UserListViewBaseState<UserListViewModel, UserListView> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
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
    model.userListScrollController.addListener(() async {
      if (model.userListScrollController.position.maxScrollExtent ==
          model.userListScrollController.position.pixels &&
          !model.busy) {
        setState(() {
          model.setBusy(true);
        });
        print('List End: Loading more user');
        await model.getUserList(params:
        GetUsersUseCaseParams(model.page)).then((response) {
          model.userList.addAll(response);
        });
        setState(() {
          model.setBusy(false);
        });
      }
    });

    await model.getUserList(params: GetUsersUseCaseParams(model.page));
    print('initState userListScreen');
  }

  @override
  UserListViewModel initViewModel() {

    return UserListViewModel(Provider.of<GetUsersUseCase>(context));

  }

  @override
  Color statusBarColor() {
    return Color(0xFF181822);
  }
}
