import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:git_users/domain/usecase/add_user_hive_usecase.dart';
import 'package:git_users/domain/usecase/get_user_list_usecase.dart';
import 'package:git_users/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'list_view_model.dart';

class BaseListViewWidget extends StatelessWidget {
  dynamic connectivity;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BaseListViewModel>(
      viewModel: BaseListViewModel(
        getUsersUseCase: Provider.of(context),
        userListScrollController: ScrollController(),
        addUsersUseCase: Provider.of(context, listen: false),
      ),
      onModelReady: (model) async {
        await model.getUserList(params: GetUsersUseCaseParams(model.page));
        model.userListScrollController.addListener(() async {
          if (model.userListScrollController.position.maxScrollExtent ==
                  model.userListScrollController.position.pixels &&
              !model.busy) {
            model.onScroll();
          }
        });
      },
      builder: (context, model, child) {
        if (model.notConnected)
          return Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Center(
              child: Text('Please check your internet connection'),
            ),
          );
        else
          return
            // Stack(
            // children: [
              SingleChildScrollView(
                controller: model.userListScrollController,
                child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Colors.indigo[900].withOpacity(0.35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                8,
                                12,
                                8,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${model.selectedUserList.length}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const TextSpan(text: 'Selected'),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      // setState(() {
                                      //   selectedUsersMap.clear();
                                      //   inSelectionMode = false;
                                      // });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 12),
                  physics: BouncingScrollPhysics(),
                  itemCount: !model.busy
                      ? model.userList.length + 1
                      : model.userList.length,
                  //+1 for the CupertinoActivityIndicator
                  itemBuilder: (context, index) {
                    // UserItem usr = model.userList[index];

                    model.page = model.userList.length;
                    if (!model.busy && index == model.userList.length) {
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
                              S.of(context).loadingMore,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return GestureDetector(
                        onTap: () async {
                          model.returnAvailable(index);
                          model.selectCard(
                            model.userList[index],
                            params: AddHiveUsersUseCaseParams(model.userList)
                          );
                        },
                        child: Container(
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
                            border: Border.all(
                              color: (model.userList[index].isSelected)
                                  ? Colors.green.withOpacity(0.8)
                                  : Colors.blue[500],
                              width: 2,
                            ),
                            color: (model.userList[index].isSelected)
                                ? Colors.green.withOpacity(0.5)
                                : Colors.blue[500],
                            borderRadius: BorderRadius.circular(8),

                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF333388).withOpacity(0.35),
                                  blurRadius: 40,
                                  offset: Offset(0, 12)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  width: 120,
                                  height: 200,
                                  child: CachedNetworkImage(
                                    imageUrl: model.userList[index].avtar,
                                    placeholder: (context, url) => Container(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                    errorWidget: (context, url, child) =>
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 18),
                                      Flexible(
                                        child: Text(
                                          model.userList[index].login,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.65),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        height: 2,
                                        width: 34,
                                        color: Colors.black54,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.black54,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.black54,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.black54,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.black54,
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 16,
                                            color: Colors.grey[300]
                                                .withOpacity(0.8),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4),
                                            child: Text(
                                              '(${model.userList[index].login})',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white
                                                    .withOpacity(0.75),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12),
                                        child: Text(
                                          S.of(context).id +
                                              '${model.userList[index].id}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.white.withOpacity(0.65),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12),
                                        child: Text(
                                          S.of(context).followersTag,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Colors.white.withOpacity(0.65),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          S.of(context).followingTag,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.75),
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
                        ));
                  },
                ),
              ],
                    ),
              );
              // Visibility(
              //   visible: model.selectionModeOn,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: RaisedButton(
              //         onPressed: () {
              //           model.addUser(AddHiveUsersUseCaseParams(model.selectedUserList));
              //         },
              //         color: Colors.white,
              //         child: Text('Add Users', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
              //       ),
              //     ),
              //   ),
              // )
          //   ],
          // );
      },
    );
  }

}
