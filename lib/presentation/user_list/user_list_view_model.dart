
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';
import 'package:git_users/presentation/model/user_item.dart';

class UserListViewModel extends GitUserLandingBaseViewModel {
  //network call
  GetUsersUseCase _getUsersUseCase;

  UserListViewModel(this._getUsersUseCase);
  List<UserItem> _userList = [];
  final scrollController = ScrollController();
  final scrollThreshold = 200.0;
  final nowPlayingPageController = PageController(viewportFraction: 1);
  int nowPlayingMoviesCount = 0;
  int currentNowPlayingPageIndex = 0;
  List<UserItem> get movieList => _userList;

  set movieList(List<UserItem> value) {
    _userList = value;
    notifyListeners();
  }

  void autoSlideNowPlayingPages() {
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (nowPlayingMoviesCount > 1) {
        if (currentNowPlayingPageIndex < nowPlayingMoviesCount) {
          currentNowPlayingPageIndex++;
        } else {
          currentNowPlayingPageIndex = 0;
        }

        nowPlayingPageController.animateToPage(
          currentNowPlayingPageIndex,
          duration: Duration(milliseconds: 750),
          curve: Curves.easeIn,
        );
      }
    });
  }
  Future<void> getUserList() async {
    //if the data is loading
    setBusy(true);
    final List<UserItem> result = await _getUsersUseCase
        .buildUseCaseFuture()
        .catchError((error) {
      print("error> ${error.toString()}");
      movieList.clear();

      setBusy(false);
    }, test: (error) => error is UserListLandingError);
    _userList = [];
    if (result != null) {
      movieList.addAll(result);
      print('length of the movie list is as follows ${movieList.length}');
    }
    setBusy(false);
    // return result;
  }


}
