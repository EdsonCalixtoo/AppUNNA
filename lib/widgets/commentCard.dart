import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/postController.dart';
import '../screens/user_profile_external.dart';

import '../models/comment.dart';

class CommentCard extends StatelessWidget {
  final CommentModel comment;
  final String loggedUserHandle;
  final Function onDelete;
  const CommentCard({
    Key? key,
    required this.comment,
    required this.loggedUserHandle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // color: Colors.yellow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.find<PostController>()
                  .updateFilter('posts_profile_user', comment.userHandle);
              Get.off(ProfileExternalScreen(), arguments: {
                'userImage': comment.userImage,
                'userHandle': comment.userHandle,
                'userName': comment.userName
              });
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 17.0,
                    offset: Offset(0, 12),
                    spreadRadius: 1,
                  )
                ],
                // boxShadow: kElevationToShadow[7],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: comment.userImage,
                  height: 41.0,
                  width: 41.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: new BoxDecoration(
                color: Colors.grey[200],
                borderRadius: new BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            comment.userHandle.split('@')[0],
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Text(
                            comment.dateCreatedAt != null
                                ? DateFormat('dd.MM hh:mm')
                                    .format(comment.dateCreatedAt!.toDate())
                                    .toString()
                                : '',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          )
                        ],
                      ),
                      num.tryParse(comment.id) == null
                          ? comment.userHandle == loggedUserHandle
                              ? GestureDetector(
                                  onTap: () {
                                    onDelete();
                                  },
                                  child: Icon(Icons.delete, color: Colors.grey))
                              : Container()
                          : Container()
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(comment.body),
                ],
              ),
            ),
          ),
        ],
      ),

      // Text(comment.body),
    );
  }
}
