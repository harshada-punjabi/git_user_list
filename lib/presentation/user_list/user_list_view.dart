import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base_architecture/responsive/orientation_layout.dart';
import 'package:flutter_base_architecture/responsive/screen_type_layout.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/user_list/user_list_view_model.dart';
import 'package:provider/provider.dart';


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
        portrait: (context) => Container(
          color: Colors.black,
          child: Center(
            child: Text('add the view here'),),),
      ),
    );

  }
  @override
  void onModelReady(UserListViewModel model) async{
    //widget is created
    model.scrollController.addListener(onScroll);

    await model.getUserList();
    print('initState userListScreen');


  }
  @override
  UserListViewModel initViewModel() {

    return UserListViewModel(Provider.of(context));
  }
  void onScroll() {
    final maxScroll = getViewModel().scrollController.position.maxScrollExtent;
    final currentScroll = getViewModel().scrollController.position.pixels;
    if (maxScroll - currentScroll <= getViewModel().scrollThreshold) {

    }
  }

  @override
  Color statusBarColor() {
    return Color(0xFF181822);
  }
}
