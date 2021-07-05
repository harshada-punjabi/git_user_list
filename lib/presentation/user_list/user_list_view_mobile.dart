
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:git_users/presentation/user_list/selected_user/selected_user_view.dart';

import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/user_list/all_user_list/base_list_view.dart';
import 'user_list_view_model.dart';

class UserListViewMobile extends UserListBaseModelWidget<UserListViewModel>{
  @override
  Widget buildContent(BuildContext context,UserListViewModel model) {
    return  TabBarView(
      children: [
        BaseListViewWidget(),
        SelectedListViewWidget()
      ],
    );
  }


}




