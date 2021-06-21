
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:git_users/presentation/user_list/user_list_view_model.dart';
import 'package:git_users/presentation/base/view/git_user_landing_base_view.dart';

class UserListViewMobile extends UserListBaseModelWidget<UserListViewModel>{
  UserListViewMobile();
 final GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();

  @override
  Widget buildContent(BuildContext context,UserListViewModel model) {
    bool inSelectionMode = false;
    int selectedCardIndex = 0; //This has nothing to do with above bool, but with the masterview list tiles
    Map<String, String> selectedUsersMap = {};
    return  TabBarView(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(left: 12),
          controller: model.userListScrollController,
          physics: BouncingScrollPhysics(),
          itemCount: !model.busy
              ? model.userList.length + 1
              : model.userList
              .length, //+1 for the CupertinoActivityIndicator
          itemBuilder: (context, index) {
            model.page = model.userList.length;
            if (!model.busy &&
                index == model.userList.length) {
              return Container(
                width: 120,
                height: 290,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CupertinoActivityIndicator(radius: 15),
                    SizedBox(height: 20),
                    Text(
                      'Loading More',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              );
            }
            return GestureDetector(
              onLongPress: (){
                if (!selectedUsersMap.containsKey(model.userList[index].id)) {
                  model.notifyListeners();
                    if (!inSelectionMode) {
                      inSelectionMode = true;
                    selectedUsersMap
                        .addAll({
                      model.userList[index].id.toString(): model.userList[index].login});
                  }
                }
              },
              onTap: () {
                if (inSelectionMode && selectedUsersMap.isNotEmpty) {
                  if (selectedUsersMap.containsKey(model.userList[index].id)) {
                    model.notifyListeners();

                      selectedUsersMap.remove(model.userList[index].id);
                      if (selectedUsersMap.isEmpty) {
                        inSelectionMode = false;
                      }

                  } else {
                    model.notifyListeners();
                      selectedUsersMap.addAll(
                          {model.userList[index].id.toString(): model.userList[index].login});

                  }
                }
              },
              child:Container(
                height: 200,
                //width: 190,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 8,
                  bottom: 8,
                ),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  // color: Colors.grey.withOpacity(0.75),
                  color: (inSelectionMode & selectedUsersMap.containsKey(model.userList[index].id))
                      ? Colors.black.withOpacity(0.1)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color:
                    Colors.indigo.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF333388)
                            .withOpacity(0.35),
                        blurRadius: 40,
                        offset: Offset(0, 12)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(8),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        width: 120,
                        height: 200,
                        child: CachedNetworkImage(
                          imageUrl: model.userList[index].avtar,
                          placeholder: (context, url) =>
                              Container(
                                child:
                                CupertinoActivityIndicator(),
                              ),
                          errorWidget:
                              (context, url, child) =>
                              Container(
                                color: Colors.grey[800],
                              ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 18),
                    Container(
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 18),
                            Flexible(
                              child: Text(
                                model.userList[index].login,
                                maxLines: 3,
                                overflow:
                                TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white
                                      .withOpacity(0.65),
                                  fontWeight:
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets
                                  .symmetric(
                                  vertical: 12),
                              height: 2,
                              width: 34,
                              color:
                              Colors.lightBlue[500],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.lightBlue,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.lightBlue,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.lightBlue,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.lightBlue,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.grey[300]
                                      .withOpacity(0.8),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(
                                      left: 4),
                                  child: Text(
                                    '(${model.userList[index].login})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white
                                          .withOpacity(
                                          0.75),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12),
                              child: Text(
                                'Id: ${model.userList[index].id}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.w400,
                                  color: Colors.white
                                      .withOpacity(0.65),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 12),
                              child: Text(
                                'Followers: NA}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                  FontWeight.w400,
                                  color: Colors.white
                                      .withOpacity(0.65),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 8),
                              child: Text(
                                'Following: NA}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white
                                      .withOpacity(0.75),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),

                  ],
                ),
              )

            );
          },
        ),
        Container(
          child: Center(child: Text('data')),)
      ],
    );
  }


}



