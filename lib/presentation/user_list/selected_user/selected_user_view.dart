import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:git_users/datasource/local/hive/user_model.dart';
import 'package:git_users/presentation/utils/strings.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:git_users/generated/l10n.dart';
import 'package:git_users/presentation/model/user_item.dart';
import 'package:git_users/presentation/user_list/selected_user/selected_user_model.dart';
import 'package:provider/provider.dart';

class SelectedListViewWidget extends StatelessWidget {
  const SelectedListViewWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SelectedListViewModel>(
      viewModel: SelectedListViewModel(Provider.of(context)),
      onModelReady: (model){
        model.getItem();
      },
      builder: (context, model, child){
      if(model.busy){
      return CircularProgressIndicator();
    }else
      return _buildList();
      },
    );
  }
  ListView _buildList(){
    final userBox = Hive.box(Strings.userBox);
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 12),
      physics: BouncingScrollPhysics(),
      itemCount: userBox
          .length, //+1 for the CupertinoActivityIndicator
      itemBuilder: (context, index) {

        final userItem = userBox.get(index) as User;
        if (index == userBox.length) {
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
                    color:
                    Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
        }
        return Container(
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

            border: Border.all(
              color: Colors.green[300],
              width: 2,
            ),
            color: Colors.green[300],
            borderRadius: BorderRadius.circular(8),
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
                    imageUrl: userItem.avatar,
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
                          userItem.login,
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
                              '(${userItem.login})',
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
                          S.of(context).id + '${userItem.id.toString()}',
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
                          S.of(context).followersTag,
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
                          S.of(context).followersTag,
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
        );
      },
    );
  }
}
