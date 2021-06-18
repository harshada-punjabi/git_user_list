import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_architecture/exception/base_error.dart';
import 'package:flutter_base_architecture/exception/base_error_parser.dart';
import 'package:flutter_base_architecture/ui/base_model_widget.dart';
import 'package:flutter_base_architecture/ui/base_statefulwidget.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:git_users/domain/model/user_domain.dart';

import '../../../git_user_landing_page_route_path.dart';

class GitUserLandingBaseViewModel extends BaseViewModel {
  bool _dataChanged = false;

  bool get hasDataChanged => _dataChanged;

  set dataChanged(bool value) {
    _dataChanged = value;
  }

  GitUserLandingBaseViewModel({busy = false}) : super(busy: busy);
}

abstract class GitUserBaseView<VM extends GitUserLandingBaseViewModel>
    extends BaseStatefulWidget<VM> {
  GitUserBaseView({Key key}) : super(key: key);
}

abstract class UserListViewBaseState<VM extends GitUserLandingBaseViewModel,
        T extends GitUserBaseView<VM>>
    extends BaseStatefulScreen<VM, T, UserListLandingErrorParser, UserDomain> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  PreferredSizeWidget buildAppbar() {
    return PreferredSize(
      child: SizedBox.shrink(),
      preferredSize: Size(0, 0),
    );
  }

  void onModelReady(VM model) {
    model.onErrorListener((error) {
      showUserListToastMessage(getErrorMessage(error));
    });
  }

  @override
  Future<bool> userIsLoggedIn() async {
    bool status = await super.userIsLoggedIn();
    if (!status) {
      // TODO: Creating a temporary user with no onboarding experience
      await getLoggedInUser();
    }
    return status;
  }

  @override
  Widget getLayout() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor(),
      ),
      child: BaseWidget<VM>(
          viewModel: getViewModel(),
          onModelReady: onModelReady,
          builder: (context, VM model, Widget child) {
            return SafeArea(
              child: Scaffold(
                  backgroundColor: scaffoldColor(),
                  key: scaffoldKey,
                  extendBodyBehindAppBar: extendBodyBehindAppBar(),
                  extendBody: extendBody(),
                  appBar: buildAppbar(),
                  body: buildBody(),
                  bottomNavigationBar: buildBottomNavigationBar(),
                  floatingActionButton: floatingActionButton(),
                  floatingActionButtonLocation: floatingActionButtonLocation(),
                  floatingActionButtonAnimator: floatingActionButtonAnimator(),
                  persistentFooterButtons: persistentFooterButtons(),
                  drawer: drawer(),
                  endDrawer: endDrawer(),
                  bottomSheet: bottomSheet(),
                  resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
                  drawerDragStartBehavior: drawerDragStartBehavior(),
                  drawerScrimColor: drawerScrimColor(),
                  drawerEdgeDragWidth: drawerEdgeDragWidth()),
            );
          }),
    );
  }

  @override
  String onBoardingRoutePath() {
    return GitUserLandingRoutePaths.Landing;
  }

  @override
  String widgetErrorMessage() {
    return 'unexpected error';
  }

  @override
  String errorLogo() {
    return '';
  }

  @override
  Color scaffoldColor() {
    return Color(0xFF181822);
  }

  bool extendBodyBehindAppBar() {
    return true;
  }

  bool extendBody() {
    return false;
  }
}

class UserListLandingError extends BaseError {
  UserListLandingError({
    message,
    type,
    error,
    stackTrace,
  }) : super(message: message, type: type, error: error);
}

class UserListLandingErrorType extends BaseErrorType {
  const UserListLandingErrorType(value) : super(value);
  static const UserListLandingErrorType INTERNET_CONNECTIVITY =
      const UserListLandingErrorType(1);
  static const UserListLandingErrorType INVALID_RESPONSE =
      const UserListLandingErrorType(2);
  static const UserListLandingErrorType SERVER_MESSAGE =
      const UserListLandingErrorType(3);
  static const UserListLandingErrorType OTHER =
      const UserListLandingErrorType(4);
}

class UserListLandingErrorParser extends BaseErrorParser {
  UserListLandingErrorParser() : super();
}

abstract class UserListBaseModelWidget<VM>
    extends BaseModelWidget<VM, UserListLandingErrorParser> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  @mustCallSuper
  Widget build(context, VM model) {
    return buildContent(context, model);
  }

  Widget buildContent(BuildContext context, VM model);
}

showUserListToastMessage(
  String message, {
  Color backgroundColor,
  Color textColor,
  ToastGravity gravity: ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 3,
    backgroundColor: backgroundColor != null
        ? backgroundColor
        : Colors.black.withOpacity(0.5),
    textColor: textColor != null ? textColor : Colors.white,
    fontSize: 14,
  );
}
