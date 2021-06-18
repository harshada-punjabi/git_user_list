import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:git_users/presentation/user_list/user_list_view.dart';
import 'package:page_transition/page_transition.dart';

import 'git_user_landing_page_route_path.dart';

class GitUserLandingRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case GitUserLandingRoutePaths.Landing:
        return PageTransition(
          child: UserListView(),
          settings: RouteSettings(name: GitUserLandingRoutePaths.Landing),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 450),
        );
      break;
    }
  }
}
