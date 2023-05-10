import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../screens/user_profile_external.dart';
import '../controllers/postController.dart';
import '../screens/post_comment.dart';
import '../controllers/userController.dart';
import '../widgets/likeButton.dart';
import '../models/post.dart';

// ignore: must_be_immutable
class PostCard extends StatelessWidget {
  final PostModel post;

  PostCard({Key? key, required this.post}) : super(key: key);

  PostController postController = Get.find<PostController>();

  Widget imagePost(BuildContext context, String? urlImagem) {
    var widtSize = MediaQuery.of(context).size.width * 0.7;

    return GestureDetector(
      onTap: () {
        Get.to(PostCommentScreen(), arguments: post);
      },
      child: Container(
        height: widtSize,
        margin: EdgeInsets.all(0),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(urlImagem != null
                ? urlImagem
                : 'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/zSocialImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c'),
            fit: BoxFit.cover,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 35.0,
              offset: Offset(1, 15.75),
            )
          ],
          color: Colors.blue,
          borderRadius: new BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget userLine() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  postController.updateFilter(
                      'posts_profile_user', post.userHandle!);
                  Get.to(ProfileExternalScreen(), arguments: {
                    'userImage': post.userImage,
                    'userHandle': post.userHandle,
                    'userName': post.userName
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
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: post.userImage!,
                      height: 51.0,
                      width: 51.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userHandle!.split('@')[0],
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  SizedBox(height: 5),
                  Text(
                    DateFormat('dd.MM hh:mm')
                        .format(post.createdAt!.toDate())
                        .toString(),
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
        Icon(
          Icons.more_horiz,
          size: 30,
        )
      ],
    );
  }

  Widget textBody() {
    return post.body != ''
        ? Row(
            children: [
              Expanded(
                child: Container(
                  // color: Colors.blue,
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Text(
                    post.body!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        : Container();
  }

  Widget baseLine(bool isLiked, Function onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 90,
                      // color: Colors.green,
                      child: Row(
                        children: [
                          LikeButton(
                              isLiked: isLiked == true, onTap: () => onTap()),
                          Expanded(
                            child: Text(
                              post.likeCount! > 0
                                  ? post.likeCount.toString()
                                  : '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      width: 80,
                      // color: Colors.yellow,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(PostCommentScreen(), arguments: post);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              post.commentCount! > 0
                                  ? Icons.sms_outlined
                                  : Icons.chat_bubble_outline,
                              size: 25,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                post.commentCount! > 0
                                    ? post.commentCount.toString()
                                    : '',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              postController.updateFilter(post.category!, '');
            },
            child: Container(
                height: 50,
                // color: Colors.green,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        post.category!,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Icon(
                      Icons.flag_outlined,
                      size: 28,
                      color: Colors.black54,
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: [
          userLine(),
          SizedBox(height: 15),
          imagePost(context, post.postImage!),
          textBody(),
          GetX<UserController>(
              // init: Get.put<CourseController>(CourseController()),
              builder: (UserController userController) {
            return baseLine(post.likes!.contains(userController.user.id), () {
              postController.toggleLike(userController.user.id!, post);
            });
          }),
        ],
      ),
    );
  }
}
