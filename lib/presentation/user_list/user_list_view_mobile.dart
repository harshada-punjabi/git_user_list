
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:git_users/presentation/user_list/selected_user/selected_user_view.dart';
import 'package:git_users/presentation/user_list/user_list_view_model.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/user_list/all_user_list/base_list_view.dart';

class UserListViewMobile extends UserListBaseModelWidget<UserListViewModel>{
  UserListViewMobile();
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



